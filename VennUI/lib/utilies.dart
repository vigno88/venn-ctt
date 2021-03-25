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

const Color baseColor = Color(0xff222f3e);
const Color infoColor = Color(0xff576574);
const Color paleColor = Color(0xff8395a7);
const Color oldBaseColor = Color(0xff14121f);
final Color paleBlue = Color(0xff54a0ff);
final Color darkBlue = Color(0xff2e86de);

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

List<BoxShadow> tileShadows(
    double offset, double spreadRadius, double blurRadius) {
  return [
    BoxShadow(
      color: paleColor.withOpacity(0.3),
      spreadRadius: spreadRadius,
      blurRadius: blurRadius,
      offset: Offset(0, offset),
    ),
    BoxShadow(
      color: Colors.white.withOpacity(0.5),
      spreadRadius: spreadRadius,
      blurRadius: blurRadius,
      offset: Offset(0, -offset),
    ),
  ];
}
