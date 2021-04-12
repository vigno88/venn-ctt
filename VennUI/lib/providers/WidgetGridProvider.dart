import 'package:VennUI/components/ActionButton.dart';
import 'package:VennUI/components/Grid.dart';
import 'package:VennUI/providers/MetricProvider.dart';
import 'package:flutter/material.dart';

import 'package:VennUI/utilies.dart';
import 'package:tuple/tuple.dart';

final chipTemp = MetricChip(Key("0"),
    MetricTile("Water", 40.5, "°c", "Temperature", "Temp", 0, false), 1.0);
final chipSpeed = MetricChip(
    Key("1"), MetricTile("Motor 1", 20, "RPM", "Speed", "Temp", 0, false), 1.0);
final chipSpeed2 = MetricChip(Key("2"),
    MetricTile("Massage 1", 20, "C/s", "Speed", "Temp", 0, false), 1.0);

class WidgetGridProvider with ChangeNotifier {
  final grid = Grid();

  List<Widget> dragTargets = [];
  List<Widget> dashboardTiles = [
    Tile(chipTemp, false, 2, 1),
    Tile(chipSpeed, false, 2, 1),
    Tile(chipSpeed, false, 2, 1),
    Tile(chipSpeed, false, 2, 1),
    Tile(chipSpeed2, false, 2, 1),
    Tile(chipSpeed2, false, 2, 1),
    Tile(chipSpeed2, false, 2, 1),
    Tile(
        Container(
            padding: EdgeInsets.all(20),
            child: GridView.count(
              crossAxisCount: 2,
              scrollDirection: Axis.horizontal,
              crossAxisSpacing: 70,
              mainAxisSpacing: 70,
              children: [
                ActionButton("Pistons 1", "OPEN", null),
                ActionButton("Pistons 2", "OPEN", null),
                ActionButton("Pistons 3", "OPEN", null),
                ActionButton("Pistons 4", "OPEN", null),
                ActionButton("Pistons 5", "OPEN", null),
                ActionButton("Pistons 6", "OPEN", null),
                ActionButton("All Pistons", "OPEN", null),
              ],
            )),
        false,
        4,
        2),
    Tile(
        Container(
            padding: EdgeInsets.all(20),
            child: GridView.count(
              crossAxisCount: 2,
              scrollDirection: Axis.horizontal,
              crossAxisSpacing: 70,
              mainAxisSpacing: 70,
              children: [
                ActionButton("Home", "START", null),
                ActionButton("Cycle", "START", null)
              ],
            )),
        false,
        1,
        2),
    Tile(
        Container(
          padding: EdgeInsets.all(20),
          // child: GridView.count(
          //   crossAxisCount: 2,
          //   scrollDirection: Axis.horizontal,
          //   crossAxisSpacing: 30,
          //   mainAxisSpacing: 30,
          //   children: [
          child: ActionButton("Water", "START", null),
          //   ActionButton("Roller 2", "Open", null)
          // ],
        ),
        false,
        1,
        1),
  ];

  List<Tuple2> tilePositions = [
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
  ];

  int numPages = 1;
  int activeIndex = 0;

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
