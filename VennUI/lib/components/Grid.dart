import 'package:VennUI/utilies.dart';
import 'package:flutter/material.dart';

class Grid {
  final double cellHeight = 230;
  final double cellWidth = 230;
  final int width = 8;
  final int height = 4;
}

class CellDragTarget extends StatelessWidget {
  final Grid grid;
  final int posX;
  final int posY;
  final bool visible = true;

  CellDragTarget(this.posX, this.posY, this.grid);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: posX * grid.cellWidth,
        top: posY * grid.cellHeight,
        child: DragTarget(
          builder: (context, candidateData, rejectedData) {
            if (visible) {
              return Container(
                height: grid.cellHeight,
                width: grid.cellWidth,
                padding: EdgeInsets.all(40),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.white),
                    color: paleColor.withOpacity(0.1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ));
  }
}

class DashboardWidget extends StatefulWidget {
  final posX;
  final posY;
  final Grid grid;
  final double padding = 15;
  final Tile tile;

  DashboardWidget(
    this.posX,
    this.posY,
    this.grid,
    this.tile,
  );

  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.posX * widget.grid.cellWidth,
      top: widget.posY * widget.grid.cellHeight,
      // child: Draggable(
      child: Container(
        width: widget.grid.cellWidth * widget.tile.width,
        height: widget.grid.cellHeight * widget.tile.height,
        padding: EdgeInsets.fromLTRB(
            widget.padding, widget.padding, widget.padding, widget.padding),
        child: widget.tile,
      ),
      // feedback: Container(
      //   width: widget.grid.cellWidth * widget.tile.width,
      //   height: widget.grid.cellHeight * widget.tile.height,
      //   padding: EdgeInsets.fromLTRB(
      //       widget.padding, widget.padding, widget.padding, widget.padding),
      //   child: Container(
      //     decoration: BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.all(Radius.circular(20)),
      //       boxShadow: [
      //         BoxShadow(
      //           color: paleColor.withOpacity(0.3),
      //           spreadRadius: 1,
      //           blurRadius: 5,
      //           offset: Offset(0, 15),
      //         ),
      //       ],
      //     ),
      //     child: widget.tile,
      //   ),
      // ),
      // childWhenDragging: Container(),
      // ),
    );
  }
}

class Tile extends StatelessWidget {
  final bool isFeedBack;
  final int width;
  final int height;

  Tile(this.isFeedBack, this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow:
            this.isFeedBack ? tileShadows(10, 1, 3) : tileShadows(3, 1, 3),
      ),
    );
  }
}
