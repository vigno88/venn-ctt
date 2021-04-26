import 'dart:ui';
import 'package:VennUI/providers/UserProvider.dart';
import 'package:VennUI/utilies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDialogBox extends StatefulWidget {
  const UserDialogBox({Key key}) : super(key: key);

  @override
  _UserDialogBoxState createState() => _UserDialogBoxState();
}

class _UserDialogBoxState extends State<UserDialogBox> {
  int hoverUser;

  @override
  Widget build(BuildContext context) {
    hoverUser = context.watch<UserProvider>().hoverUser;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Colors.transparent,
      child: Selector<UserProvider, bool>(
          selector: (BuildContext context, UserProvider provider) =>
              provider.isLoading,
          builder: (context, bool isLoading, _) {
            if (isLoading) {
              return Container();
            } else {
              return contentBox(context);
            }
          }),
    );
  }

  contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 455,
          width: 700,
          padding: EdgeInsets.only(left: 30, top: 20, right: 30, bottom: 10),
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Users",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: baseColor),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Currently connected using: " +
                    context.watch<UserProvider>().currentUser.title,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                    color: baseColor),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                  height: 230,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Available users",
                          style: TextStyle(
                              fontSize: 25, color: paleColor.withOpacity(0.9)),
                        ),
                        Container(
                          height: 200,
                          width: 800,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: paleColor.withOpacity(0.6)),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(),
                              padding: const EdgeInsets.all(8),
                              itemCount:
                                  context.watch<UserProvider>().userList.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (index ==
                                    context.watch<UserProvider>().hoverUser) {
                                  return UserItem(
                                      index,
                                      context
                                          .watch<UserProvider>()
                                          .userList[index]
                                          .title,
                                      true);
                                }
                                return UserItem(
                                    index,
                                    context
                                        .watch<UserProvider>()
                                        .userList[index]
                                        .title,
                                    false);
                              }),
                        ),
                      ])),
              SizedBox(
                height: 22,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    UserButton("Change User", () => updateUser(context)),
                  ]),
            ],
          ),
        ),
      ],
    );
  }

  void updateUser(BuildContext context) {
    context.read<UserProvider>().updateCurrentUser(hoverUser);
    Navigator.of(context).pop();
  }
}

class UserItem extends StatelessWidget {
  final int _index;
  final String _title;
  final bool _isSelected;

  UserItem(
    this._index,
    this._title,
    this._isSelected,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => context.read<UserProvider>().updateUserHover(_index),
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: _isSelected ? paleBlue.withOpacity(0.2) : Colors.white,
              border: _isSelected ? blueBorderDecoration : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  (_index + 1).toString(),
                  style: TextStyle(
                      color:
                          _isSelected ? darkBlue : paleColor.withOpacity(0.6),
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        _title,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class UserButton extends StatefulWidget {
  final String text;
  final Function onTap;

  UserButton(this.text, this.onTap);

  @override
  _UserButtonState createState() => _UserButtonState();
}

class _UserButtonState extends State<UserButton>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 2,
      ),
      lowerBound: 0.5,
      upperBound: 1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      onTap: () => widget.onTap(),
      child: Container(
        height: 60,
        width: 190,
        decoration: BoxDecoration(
            color: paleBlue.withOpacity(0.4),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow:
                tileShadows(5 * _scale, 1 * _scale, 3 * _scale, paleColor)),
        child: Material(
            color: Colors.transparent,
            child: Center(
              child: Text(
                this.widget.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w600,
                    color: baseColor),
              ),
            )),
      ),
    );
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }
}
