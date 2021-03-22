import 'package:VennUI/utilies.dart';
import 'package:flutter/material.dart';

class CellDragTarget extends StatelessWidget {
  final int posX;
  final int posY;
  final double width;
  final double height;
  final bool visible = true;

  CellDragTarget(this.posX, this.posY, this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: posX * width.toDouble(),
        top: posY * height.toDouble(),
        child: DragTarget(
          builder: (context, candidateData, rejectedData) {
            if (visible) {
              return Container(
                height: height,
                width: width,
                padding: EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
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
