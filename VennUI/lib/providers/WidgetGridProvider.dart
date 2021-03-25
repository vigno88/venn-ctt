import 'package:VennUI/components/Grid.dart';
import 'package:flutter/material.dart';

import 'package:VennUI/utilies.dart';
import 'package:tuple/tuple.dart';

class WidgetGridProvider with ChangeNotifier {
  final grid = Grid();

  List<Widget> dragTargets = [];
  List<Widget> dashboardTiles = [
    Tile(false, 2, 2),
    Tile(false, 2, 2),
    Tile(false, 1, 2),
    Tile(false, 1, 2),
    Tile(false, 2, 1),
    Tile(false, 2, 1),
    Tile(false, 4, 2),
    Tile(false, 1, 1),
    Tile(false, 1, 1),
  ];

  List<Tuple2> tilePositions = [
    Tuple2(0, 0),
    Tuple2(2, 2),
    Tuple2(0, 2),
    Tuple2(1, 2),
    Tuple2(2, 0),
    Tuple2(2, 1),
    Tuple2(4, 0),
    Tuple2(6, 2),
    Tuple2(6, 3),
  ];

  int numPages = 6;
  int activeIndex = 1;

  WidgetGridProvider();

  void setActivePageIndex(int i) {
    if (i < 0 || i > numPages) {
      throw ('Invalid page index');
    }
    activeIndex = i;
    notifyListeners();
  }

  List<Widget> getWidgets() {
    List<Widget> widgets = getDragTargets();
    widgets.addAll(getDashboardWidgets());
    return widgets;
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
    List<Widget> dashboardWidgets = [];
    for (int i = 0; i < dashboardTiles.length; i++) {
      dashboardWidgets.add(DashboardWidget(tilePositions[i].item1,
          tilePositions[i].item2, grid, dashboardTiles[i]));
    }
    return dashboardWidgets;
  }
}
