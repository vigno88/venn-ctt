import 'package:VennUI/grpc/authentification.dart';
import 'package:flutter/material.dart';
import 'package:VennUI/grpc/v1/ui.pb.dart' as proto;

// Network provider is used to connect the raspberry PI to the internet
class UserProvider with ChangeNotifier {
  AuthentificationGrpcAPI _authAPI;

  List<proto.User> userList = [];
  int hoverUser = -1;
  bool isLoading = true;
  proto.User currentUser;

  UserProvider(AuthentificationGrpcAPI a) {
    _authAPI = a;
    initiate();
  }

  void initiate() async {
    currentUser = await _authAPI.getCurrentUser();
    var users = await _authAPI.readUserList();
    userList = users.users;
    isLoading = false;
    notifyListeners();
  }

  void updateCurrentUser(int i) {
    _authAPI.updateCurrentUser(userList[i]);
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
