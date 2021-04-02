import 'dart:ui';
import 'package:VennUI/providers/NetworkProvider.dart';
import 'package:VennUI/utilies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:VennUI/virtualKeyboard/virtualKeyboard.dart';
import 'package:provider/provider.dart';

class WifiDialogBox extends StatefulWidget {
  const WifiDialogBox({Key key}) : super(key: key);

  @override
  _WifiDialogBoxState createState() => _WifiDialogBoxState();
}

class _WifiDialogBoxState extends State<WifiDialogBox> {
  int hoverRecipe;
  var textController = TextEditingController();
  bool isCapsOn = false;

  @override
  Widget build(BuildContext context) {
    hoverRecipe = context.watch<NetworkProvider>().hoverSSID;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Colors.transparent,
      child: Selector<NetworkProvider, bool>(
          selector: (BuildContext context, NetworkProvider provider) =>
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
          height: 950,
          width: 1700,
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
                "Wi-Fi",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: baseColor),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Currently connected to: " +
                    context.watch<NetworkProvider>().currentWifi,
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
                          "Available Wi-Fi Networks",
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
                              itemCount: context
                                  .watch<NetworkProvider>()
                                  .wifiSSIDs
                                  .length,
                              itemBuilder: (BuildContext context, int index) {
                                if (index == hoverRecipe) {
                                  return WifiItem(
                                      index,
                                      context
                                          .watch<NetworkProvider>()
                                          .wifiSSIDs[index],
                                      true);
                                }
                                return WifiItem(
                                    index,
                                    context
                                        .watch<NetworkProvider>()
                                        .wifiSSIDs[index],
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
                    SizedBox(
                      width: 140,
                      height: 70,
                    ),
                    SizedBox(
                        height: 70,
                        width: 800,
                        child: TextField(
                          controller: textController,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                          style: TextStyle(fontSize: 27),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    WifiButton("Connect", () => connectWifi(context)),
                  ]),
              SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: paleBlue.withOpacity(0.4),
                ),
                child: VirtualKeyboard(
                    height: 450,
                    textColor: Colors.black,
                    fontSize: 28,
                    type: VirtualKeyboardType.Alphanumeric,
                    onKeyPress: (key) => updateKeyboard(key)),
              )
            ],
          ),
        ),
      ],
    );
  }

  void connectWifi(BuildContext context) {
    context
        .read<NetworkProvider>()
        .connectWifi(hoverRecipe, textController.text);
    Navigator.of(context).pop();
  }

  void updateKeyboard(VirtualKeyboardKey key) {
    // Check if the key is a char value
    if (key.action == null) {
      if (isCapsOn) {
        textController.text += key.capsText;
        return;
      }
      textController.text += key.text;
      return;
    }
    if (key.action == VirtualKeyboardKeyAction.Backspace) {
      String str = textController.text;
      textController.text = str.substring(0, str.length - 1);
      return;
    }
    if (key.action == VirtualKeyboardKeyAction.Space) {
      textController.text += ' ';
      return;
    }
    if (key.action == VirtualKeyboardKeyAction.Shift) {
      isCapsOn = !isCapsOn;
      return;
    }
  }
}

class WifiItem extends StatelessWidget {
  final int _index;
  final String _title;
  final bool _isSelected;

  WifiItem(
    this._index,
    this._title,
    this._isSelected,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => context.read<NetworkProvider>().updateSSIDHover(_index),
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: _isSelected ? paleBlue.withOpacity(0.2) : Colors.white,
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

class WifiButton extends StatefulWidget {
  final String text;
  final Function f;

  WifiButton(this.text, this.f);

  @override
  _WifiButtonState createState() => _WifiButtonState();
}

class _WifiButtonState extends State<WifiButton>
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
      onTap: () => widget.f(),
      child: Container(
        height: 50,
        width: 130,
        decoration: BoxDecoration(
            color: paleBlue.withOpacity(0.4),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: tileShadows(5 * _scale, 1 * _scale, 3 * _scale)),
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
