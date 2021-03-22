import 'package:flutter/material.dart';
import 'package:VennUI/utilies.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        bottom: 5,
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 30,
              color: Colors.transparent,
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                'vennhq.com & uneed.ca',
                style:
                    TextStyle(fontSize: 19, color: paleColor.withOpacity(0.8)),
                textAlign: TextAlign.center,
              ),
            )));
  }
}
