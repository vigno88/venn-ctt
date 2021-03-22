import 'package:flutter/material.dart';
import 'package:VennUI/components/DragTarget.dart';

import '../utilies.dart';

class WidgetGridProvider with ChangeNotifier {
  final int cellHeight = 230;
  final int cellWidth = 230;
  final int gridWidth = 8;
  final int gridHeight = 4;

  List<Widget> dragTargets = [];

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

  List<Widget> getDragTargets() {
    List<Widget> targets = [];
    for (int i = 0; i < gridHeight * gridWidth; i++) {
      targets.add(CellDragTarget(
          getXCoord(i, gridWidth),
          getYCoord(i, gridWidth),
          cellWidth.toDouble(),
          cellHeight.toDouble()));
    }
    return targets;
  }
}
