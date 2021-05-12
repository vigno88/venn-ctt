import 'dart:async';

import 'package:VennUI/components/Notification.dart';
import 'package:flutter/material.dart';

// NotificationProvider expose a single widget that is displayed at the top of
// the UI pages when necessary. This widget acts as a notification for the user.
class NotificationProvider with ChangeNotifier {
  // This widget is the notification
  Widget notification = Container();

  Stream<NotificationData> _notifications;
  StreamController<NotificationData> _controller;

  NotificationProvider(StreamController<NotificationData> s) {
    _controller = s;
    _notifications = s.stream;
    run();
  }

  void run() async {
    _notifications.listen((notif) {
      displayNotification(notif);
    });
  }

  void displayNotification(NotificationData data) async {
    // Display the notfication
    notification = VennNotification(data);
    notifyListeners();
    // Wait 5 seconds
    const delay = const Duration(seconds: 5);
    Timer(delay, () {
      notification = Container();
      notifyListeners();
    });
  }
}
