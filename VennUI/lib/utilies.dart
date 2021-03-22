import 'package:flutter/material.dart';

void showModal(BuildContext context, String title, String content) {
  AlertDialog alert = AlertDialog(
    scrollable: true,
    title: Text(title),
    content: Text(content),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Color baseColor = Color(0xff222f3e);
Color infoColor = Color(0xff576574);
Color paleColor = Color(0xff8395a7);
Color oldBaseColor = Color(0xff14121f);

// const serverIP = "127.0.0.1";
const serverIP = "10.0.2.2";

int get1DCoord(int x, int y, int width) {
  return x + width * y;
}

int getYCoord(int i, int width) {
  return i ~/ width;
}

int getXCoord(int i, int width) {
  return i % width;
}
