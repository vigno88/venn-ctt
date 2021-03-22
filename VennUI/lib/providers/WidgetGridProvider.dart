import 'package:VennUI/components/Grid.dart';
import 'package:flutter/material.dart';

import 'package:VennUI/utilies.dart';

class WidgetGridProvider with ChangeNotifier {
  final grid = Grid();

  List<Widget> dragTargets = [];
  // List<Widget> dashboardWidgets =

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
    dashboardWidgets.add(DashboardWidget(0, 0, 2, 2, grid, Tile(false)));
    dashboardWidgets.add(DashboardWidget(2, 2, 2, 2, grid, Tile(false)));
    dashboardWidgets.add(DashboardWidget(0, 2, 2, 1, grid, Tile(false)));
    dashboardWidgets.add(DashboardWidget(1, 2, 2, 1, grid, Tile(false)));
    dashboardWidgets.add(DashboardWidget(2, 0, 1, 2, grid, Tile(false)));
    dashboardWidgets.add(DashboardWidget(2, 1, 1, 2, grid, Tile(false)));
    dashboardWidgets.add(DashboardWidget(4, 0, 2, 4, grid, Tile(false)));
    dashboardWidgets.add(DashboardWidget(6, 2, 1, 1, grid, Tile(false)));
    dashboardWidgets.add(DashboardWidget(6, 3, 1, 1, grid, Tile(false)));
    return dashboardWidgets;
  }
}
