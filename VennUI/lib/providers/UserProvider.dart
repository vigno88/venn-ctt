import 'package:VennUI/api/authentification_service.dart';
import 'package:flutter/material.dart';
import 'package:VennUI/api/network_service.dart';
import 'package:VennUI/api/v1/ui.pb.dart' as proto;

// Network provider is used to connect the raspberry PI to the internet
class UserProvider with ChangeNotifier {
  AuthentificationService authService;

  List<String> userList = ["Operator", "Admin", "Maker"];
  int hoverUser = -1;

  String currentUser = "Operator";

  UserProvider(AuthentificationService a) {
    authService = a;
  }

  void updateUserHover(int i) {
    if (i == hoverUser) {
      hoverUser = -1;
    }
    hoverUser = i;
    notifyListeners();
  }
}
