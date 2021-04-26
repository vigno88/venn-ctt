import 'package:VennUI/components/Grid.dart';
import 'package:VennUI/providers/dashboard_services/Control.dart';
import 'package:VennUI/providers/dashboard_services/Metrics.dart';
import 'package:flutter/material.dart';
import 'package:VennUI/utilies.dart';
import 'package:tuple/tuple.dart';

// DashboardProvider act as a proxy between the different dashboard services
// and the UI. It gathers widgets from the services to display them and updates
// them when required through update received in the service update stream.
// This way the UI is always up to date
class DashboardProvider with ChangeNotifier {
  // grid contains information about our current grid setup
  final grid = Grid();
  MetricService metricService;
  ControlService controlService;

  // modifiedTileIndex tells to the Selector (of this provider) which tiles needs to be updated
  int modifiedTileIndex;
  // numPages tells the number of pages there is in the dashboard
  int numPages = 1;
  // activeIndex tells the current active page
  int activeIndex = 0;
  // isLoading tells when loading of initial data is done
  bool isLoading = true;
  // isAlert tells when a tile is in alert state
  bool isAlert = false;

  // dragTargets are placeholder for tiles that will be used when tiles are movable
  List<Widget> _dragTargets = [];

  List<Widget> widgets = [];

  // tilePositions are the position of each of the widget on the grid
  List<Tuple2> _tilePositions = [
    Tuple2(0, 0),
    Tuple2(0, 1),
    Tuple2(2, 0),
    Tuple2(2, 1),
    Tuple2(4, 0),
    Tuple2(4, 1),
    Tuple2(6, 0),
    Tuple2(0, 2),
    Tuple2(4, 2),
    Tuple2(5, 2),
    Tuple2(6, 1), // Pression widget
  ];

  DashboardProvider(MetricService m, ControlService c) {
    metricService = m;
    controlService = c;
    initiate();
  }

  void initiate() async {
    // Wait until both service initiate
    await metricService.initiate();
    await controlService.initiate();
    _dragTargets = getDragTargets();
    isLoading = false;
    // Get the list of widgets to display on dashboard
    widgets = new List<Widget>.from(getWidgets());
    notifyListeners();

    // Listen to the update stream of the metric service
    metricService.updateStream.listen((update) {
      modifiedTileIndex = _dragTargets.length + update;
      // Get the updated list of widgets
      widgets[modifiedTileIndex] = getWidgets()[modifiedTileIndex];
      notifyListeners();
    });

    // Listen to the update stream of the control service
    controlService.updateStream.listen((update) {
      modifiedTileIndex =
          _dragTargets.length + metricService.numberOfTiles + update;
      // Get the updated list of widgets
      widgets[modifiedTileIndex] = getWidgets()[modifiedTileIndex];
      notifyListeners();
    });
  }

  List<Tile> getTiles() {
    List<Tile> tiles = new List<Tile>.from(metricService.getTiles());
    tiles.addAll(controlService.getTiles());
    tiles.add(Tile(PressionChip([]), false, 2, 1));
    return tiles;
  }

  void setActivePageIndex(int i) {
    if (i < 0 || i > numPages) {
      throw ('Invalid page index');
    }
    activeIndex = i;
    notifyListeners();
  }

  List<Widget> getWidgets() {
    List<Widget> w = new List<Widget>.from(_dragTargets);
    w.addAll(getDashboardWidgets());
    return w;
  }

  List<Widget> getDragTargets() {
    List<Widget> targets = [];
    for (int i = 0; i < grid.height * grid.width; i++) {
      targets.add(CellDragTarget(
          getXCoord(i, grid.width), getYCoord(i, grid.width), grid));
    }
    return targets;
  }

  List<Widget> getDashboardWidgets() {
    List<Tile> tiles = new List<Tile>.from(getTiles());
    List<Widget> dashboardWidgets = [];
    for (int i = 0; i < tiles.length; i++) {
      dashboardWidgets.add(DashboardWidget(
          _tilePositions[i].item1, _tilePositions[i].item2, grid, tiles[i]));
    }
    return dashboardWidgets;
  }

  void pressButton(BuildContext context, int buttonIndex, int tileIndex) {
    controlService.pressButton(context, buttonIndex, tileIndex);
  }
}
