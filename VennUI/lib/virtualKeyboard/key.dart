import 'package:VennUI/virtualKeyboard/key_type.dart';
import 'package:VennUI/virtualKeyboard/key_action.dart';
import 'package:flutter/material.dart';

/// Virtual Keyboard key
class VirtualKeyboardKey {
  final String text;
  final String capsText;
  final VirtualKeyboardKeyType keyType;
  final VirtualKeyboardKeyAction action;

  VirtualKeyboardKey(
      {this.text, this.capsText, @required this.keyType, this.action});
}
