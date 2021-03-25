import 'package:VennUI/api/utilities.dart';
import 'package:grpc/grpc.dart';
import 'package:VennUI/api/v1/ui.pbgrpc.dart' as grpc;
import 'package:VennUI/api/v1/ui.pb.dart' as proto;
import 'package:VennUI/utilies.dart';

/// NetworkService client implementation
class NetworkService {
  // Flag is indicating that client is shutting down
  bool _isShutdown = false;

  // gRPC client channel to send messages to the server
  ClientChannel _clientSend;

  // gRPC client channel to receive messages from the server
  ClientChannel _clientReceive;

  NetworkService() {
    _clientSend = newClient(serverIP, serverPort);
  }

  // Shutdown client
  Future<void> shutdown() async {
    _isShutdown = true;
    _shutdownSend();
    _shutdownReceive();
  }

  // Shutdown client (send channel)
  void _shutdownSend() {
    if (_clientSend != null) {
      _clientSend.shutdown();
      _clientSend = null;
    }
  }

  // Shutdown client (receive channel)
  void _shutdownReceive() {
    if (_clientReceive != null) {
      _clientReceive.shutdown();
      _clientReceive = null;
    }
  }

  // Asynchronous function to read the list of wifi ssids from the backend
  Future<proto.WifiNames> readWifiList() async {
    if (_clientSend == null) {
      _clientSend = newClient(serverIP, serverPort);
    }
    try {
      var request = grpc.Empty().createEmptyInstance();
      var names =
          await grpc.NetworkServiceClient(_clientSend).readWifiList(request);
      return names;
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();
        print(e.toString());
        // Try again
        Future.delayed(retryDelay, () {
          return readWifiList();
        });
      }
    }
  }

  // Asynchronous function to connect to the wifi
  void connectWifi(proto.WifiCredentials c) async {
    if (_clientSend == null) {
      _clientSend = newClient(serverIP, serverPort);
    }
    try {
      await grpc.NetworkServiceClient(_clientSend).connectWifi(c);
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();
        print(e.toString());
        // Try again
        Future.delayed(retryDelay, () {
          return connectWifi(c);
        });
      }
    }
  }
}
