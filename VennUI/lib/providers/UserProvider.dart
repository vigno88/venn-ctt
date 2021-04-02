import 'package:VennUI/api/authentification_service.dart';
import 'package:flutter/material.dart';
import 'package:VennUI/api/v1/ui.pb.dart' as proto;

// Network provider is used to connect the raspberry PI to the internet
class UserProvider with ChangeNotifier {
  AuthentificationService authService;

  List<proto.User> userList = [];
  int hoverUser = -1;
  bool isLoading = true;
  proto.User currentUser;

  UserProvider(AuthentificationService a) {
    authService = a;
    initiate();
  }

  void initiate() async {
    currentUser = await authService.getCurrentUser();
    var users = await authService.readUserList();
    userList = users.users;
    isLoading = false;
    notifyListeners();
  }

  void updateCurrentUser(int i) {
    authService.updateCurrentUser(userList[i]);
    currentUser = userList[i];
  }

  void updateUserHover(int i) {
    if (i == hoverUser) {
      hoverUser = -1;
    }
    hoverUser = i;
    notifyListeners();
  }
}
