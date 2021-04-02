import 'package:flutter/material.dart';
import 'package:VennUI/api/network_service.dart';
import 'package:VennUI/api/v1/ui.pb.dart' as proto;

// Network provider is used to connect the raspberry PI to the internet
class NetworkProvider with ChangeNotifier {
  NetworkService networkService;

  List<String> wifiSSIDs = ["ssid-fdasfd-1", "ssid-fdasfd-1", "ssid-fdasfd-1"];
  int hoverSSID = -1;

  String currentWifi = "wifi 2134214";

  NetworkProvider(NetworkService n) {
    networkService = n;
  }

  void updateSSIDHover(int i) {
    if (i == hoverSSID) {
      hoverSSID = -1;
    }
    hoverSSID = i;
    notifyListeners();
  }
}
