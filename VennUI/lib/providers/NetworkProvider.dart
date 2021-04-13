import 'package:VennUI/grpc/network.dart';
import 'package:flutter/material.dart';
import 'package:VennUI/grpc/v1/ui.pb.dart' as proto;

// Network provider is used to connect the raspberry PI to the internet
class NetworkProvider with ChangeNotifier {
  NetworkGrpcAPI _networkAPI;

  List<String> wifiSSIDs = [];
  int hoverSSID = -1;
  bool isLoading = true;
  String currentWifi = "Not Connected";

  NetworkProvider(NetworkGrpcAPI n) {
    _networkAPI = n;
    initiate();
  }

  void initiate() async {
    // Get the current WiFi status
    var status = await _networkAPI.readStatus();
    if (status.hasIsConnected()) {
      if (status.isConnected == true) {
        currentWifi = status.sSID;
      } else {
        currentWifi = "Not Connected";
      }
    }
    // Get the list of wifi
    var wifis = await _networkAPI.readWifiList();
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
    _networkAPI.connectWifi(c);
  }
}
