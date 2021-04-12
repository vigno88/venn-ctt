import 'package:VennUI/router.dart';
import 'package:VennUI/utilies.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class TopBarIcon extends StatelessWidget {
  TopBarIcon(
    this._icon,
    this._route,
    this._size,
  );

  final Icon _icon;
  final String _route;
  final double _size;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            splashColor: Colors.grey[500],
            onTap: () {
              RouterVenn.router.navigateTo(context, _route,
                  transition: TransitionType.native);
            },
            child: Container(
              child: Center(
                  child: IconButton(
                      icon: _icon,
                      onPressed: () {
                        RouterVenn.router.navigateTo(context, _route,
                            transition: TransitionType.native);
                      },
                      iconSize: _size,
                      color: baseColor)),
              height: 60,
              width: 60,
            )));
  }
}
