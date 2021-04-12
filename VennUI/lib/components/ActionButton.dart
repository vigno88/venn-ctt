import 'package:VennUI/utilies.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  final String text;
  final Function f;
  final String title;

  ActionButton(this.title, this.text, this.f);

  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  Color colorButton = paleBlue.withOpacity(0.2);
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: 210,
      child: Column(
        children: [
          Expanded(
              child: AutoSizeText(
            widget.title,
            style: TextStyle(
                color: baseColor, fontSize: 30, fontWeight: FontWeight.bold),
            minFontSize: 10,
            maxLines: 1,
          )),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
              onTapDown: _tapDown,
              onTapUp: _tapUp,
              onTap: () => widget.f(context),
              child: Container(
                  height: 110,
                  width: 110,
                  padding: EdgeInsets.all(15),
                  decoration: new BoxDecoration(
                    border: blueBorderDecoration,
                    borderRadius: new BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: colorButton,
                  ),
                  child: Center(
                    child: AutoSizeText(
                      widget.text,
                      style: TextStyle(
                          color: darkBlue,
                          fontSize: 60,
                          fontWeight: FontWeight.bold),
                      minFontSize: 5,
                      maxLines: 1,
                    ),
                  )))
        ],
      ),
    );
  }

  void _tapUp(TapUpDetails details) {
    setState(() {
      colorButton = paleBlue.withOpacity(0.2);
    });
  }

  void _tapDown(TapDownDetails details) {
    setState(() {
      colorButton = paleBlue.withOpacity(0.25);
    });
  }
}
