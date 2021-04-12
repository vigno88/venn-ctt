import 'package:VennUI/providers/MetricProvider.dart';
import 'package:VennUI/utilies.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
  final Widget content;

  Tile(this.content, this.isFeedBack, this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow:
            this.isFeedBack ? tileShadows(10, 1, 3) : tileShadows(3, 1, 3),
      ),
      child: content,
    );
  }
}

class MetricChip extends StatelessWidget {
  MetricChip(
    Key key,
    this.tile,
    this.opacityValue,
  ) : super(key: key);

  final MetricTile tile;
  final double opacityValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showModal(context, "Information of" + tile.name, tile.info);
        },
        child: Container(
          decoration: BoxDecoration(
            color:
                tile.isAlert ? Colors.redAccent.withOpacity(0.6) : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          height: 230,
          width: 460,
          child: Row(
            children: [
              Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                    child: IconButton(
                        icon: tile.icon,
                        onPressed: () {
                          showModal(context, "Information of " + tile.name,
                              tile.info);
                        },
                        iconSize: 70.0,
                        color: Colors.white),
                  )),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: AutoSizeText.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: tile.value.toStringAsFixed(1) + " ",
                                    style: TextStyle(
                                      fontSize: 160,
                                    )),
                                TextSpan(
                                    text: tile.unit,
                                    style: TextStyle(
                                      fontSize: 125,
                                    )),
                                TextSpan(
                                    text: ' (' +
                                        tile.target.toString() +
                                        ' ' +
                                        tile.unit +
                                        ')',
                                    style: TextStyle(
                                        fontSize: 85,
                                        color: tile.hasTarget
                                            ? (tile.isAlert
                                                ? Colors.white
                                                : paleColor.withOpacity(0.7))
                                            : Colors.transparent)),
                              ],
                            ),
                            style: TextStyle(
                              color: tile.isAlert ? Colors.white : baseColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 150,
                            ),
                            maxLines: 1,
                            minFontSize: 10,
                          )),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              child: AutoSizeText.rich(
                            TextSpan(children: [
                              TextSpan(
                                  text: tile.type + " ",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: tile.isAlert
                                          ? Colors.white.withOpacity(0.6)
                                          : infoColor)),
                              TextSpan(
                                text: tile.name,
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: tile.isAlert
                                        ? Colors.white
                                        : infoColor),
                              )
                            ]),
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 50,
                            ),
                            minFontSize: 5,
                            textAlign: TextAlign.left,
                          )),
                        ],
                      )))
              // )
            ],
          ),
        ));
  }
}
