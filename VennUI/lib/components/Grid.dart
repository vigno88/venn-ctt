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
  final int width;
  final int height;
  final Grid grid;
  final double padding = 15;
  final Tile chip;

  DashboardWidget(
    this.posX,
    this.posY,
    this.height,
    this.width,
    this.grid,
    this.chip,
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
      child: Draggable(
        child: Container(
          width: widget.grid.cellWidth * widget.width,
          height: widget.grid.cellHeight * widget.height,
          padding: EdgeInsets.fromLTRB(
              widget.padding, widget.padding, widget.padding, widget.padding),
          child: widget.chip,
        ),
        feedback: Container(
          width: widget.grid.cellWidth * widget.width,
          height: widget.grid.cellHeight * widget.height,
          padding: EdgeInsets.fromLTRB(
              widget.padding, widget.padding, widget.padding, widget.padding),
          // child: widget.chip,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: paleColor.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 15),
                ),
              ],
            ),
            child: widget.chip,
          ),
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final bool isFeedBack;

  Tile(this.isFeedBack);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: paleColor.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: this.isFeedBack ? Offset(0, 15) : Offset(0, 5),
          ),
        ],
      ),
    );
  }
}
