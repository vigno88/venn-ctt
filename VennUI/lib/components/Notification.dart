import 'package:VennUI/utilies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

enum NotificationType {
  Success,
  Info,
  Warning,
  Error,
}

class NotificationData {
  final NotificationType type;
  final String text;

  NotificationData(this.type, this.text);
}

class VennNotification extends StatelessWidget {
  final NotificationData notif;

  VennNotification(this.notif);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 35,
        left: 510,
        child: Container(
          width: 900,
          height: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: getColor(),
              boxShadow: tileShadows(3, 1, 3, getColor()),
              border: Border.all(
                width: 2,
                color: getBorderColor(),
              )),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: getIcon(),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              getText(),
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              notif.text,
                              style: TextStyle(fontSize: 20),
                            ),
                          ]),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                  ])),
            ],
          ),
        ));
  }

  Color getColor() {
    switch (notif.type) {
      case NotificationType.Success:
        return Color(0xffe7faee);
      case NotificationType.Error:
        return Color(0xffffece9);
      case NotificationType.Info:
        return Color(0xffe3eefb);
      case NotificationType.Warning:
        return Color(0xfffff9e9);
      default:
        return Color(0x00000000);
    }
  }

  Color getBorderColor() {
    switch (notif.type) {
      case NotificationType.Success:
        return Color(0xffb0edc7);
      case NotificationType.Error:
        return Color(0xffffc2b8);
      case NotificationType.Info:
        return Color(0xffa5c9f4);
      case NotificationType.Warning:
        return Color(0xfffee2aa);
      default:
        return Color(0x00000000);
    }
  }

  Widget getIcon() {
    switch (notif.type) {
      case NotificationType.Success:
        return Icon(
          Ionicons.ios_checkmark_circle_outline,
          size: 40,
        );
      case NotificationType.Error:
        return Icon(
          Ionicons.ios_close_circle_outline,
          size: 40,
        );
      case NotificationType.Info:
        return Icon(
          Ionicons.ios_information_circle_outline,
          size: 40,
        );
      case NotificationType.Warning:
        return Icon(
          Ionicons.ios_alert,
          size: 40,
        );
      default:
        return null;
    }
  }

  String getText() {
    switch (notif.type) {
      case NotificationType.Success:
        return "Success";
      case NotificationType.Error:
        return "Error";
      case NotificationType.Info:
        return "Info";
      case NotificationType.Warning:
        return "Warning";
      default:
        return "";
    }
  }
}
