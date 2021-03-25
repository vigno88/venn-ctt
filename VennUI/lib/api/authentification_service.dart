import 'package:VennUI/api/utilities.dart';
import 'package:grpc/grpc.dart';
import 'package:VennUI/api/v1/ui.pbgrpc.dart' as grpc;
import 'package:VennUI/api/v1/ui.pb.dart' as proto;
import 'package:VennUI/utilies.dart';

class AuthentificationService {
  // Flag is indicating that client is shutting down
  bool _isShutdown = false;

  // gRPC client channel to send messages to the server
  ClientChannel _clientSend;

  // gRPC client channel to receive messages from the server
  ClientChannel _clientReceive;

  AuthentificationService() {
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

  // Asynchronous function to read the list of user from the backend
  Future<proto.Users> readUserList() async {
    if (_clientSend == null) {
      _clientSend = newClient(serverIP, serverPort);
    }
    try {
      var request = grpc.Empty().createEmptyInstance();
      var users = await grpc.AuthentificationServiceClient(_clientSend)
          .readUserList(request);
      return users;
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();
        print(e.toString());
        // Try again
        Future.delayed(retryDelay, () {
          return readUserList();
        });
      }
    }
  }

  // Asynchronous function to read the list of user from the backend
  void updateCurrentUser(proto.User u) async {
    if (_clientSend == null) {
      _clientSend = newClient(serverIP, serverPort);
    }
    try {
      await grpc.AuthentificationServiceClient(_clientSend)
          .updateCurrentUser(u);
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();
        print(e.toString());
        // Try again
        Future.delayed(retryDelay, () {
          return updateCurrentUser(u);
        });
      }
    }
  }
}
