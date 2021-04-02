import 'package:flutter/material.dart';
import 'package:VennUI/api/network_service.dart';
import 'package:VennUI/api/v1/ui.pb.dart' as proto;

// Network provider is used to connect the raspberry PI to the internet
class NetworkProvider with ChangeNotifier {
  NetworkService networkService;

  List<String> wifiSSIDs = [];
  int hoverSSID = -1;
  bool isLoading = true;
  String currentWifi = "Not Connected";

  NetworkProvider(NetworkService n) {
    networkService = n;
    initiate();
  }

  void initiate() async {
    // Get the current WiFi status
    var status = await networkService.readStatus();
    if (status.hasIsConnected()) {
      if (status.isConnected == true) {
        currentWifi = status.sSID;
      } else {
        currentWifi = "Not Connected";
      }
    }
    // Get the list of wifi
    var wifis = await networkService.readWifiList();
    if (wifis.sSIDs != null) {
      wifiSSIDs = wifis.sSIDs;
    }
    isLoading = false;
    notifyListeners();
  }

  void updateSSIDHover(int i) {
    if (i == hoverSSID) {
      hoverSSID = -1;
    }
    hoverSSID = i;
    notifyListeners();
  }

  void connectWifi(int i, String password) {
    if (i < 0 || i >= wifiSSIDs.length) {
      return;
    }
    var c = proto.WifiCredentials(password: password, sSID: wifiSSIDs[i]);
    networkService.connectWifi(c);
  }
}
