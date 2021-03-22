import 'package:grpc/grpc.dart';
import 'package:VennUI/api/v1/ui.pbgrpc.dart' as grpc;
import 'package:VennUI/utilies.dart';

const serverPort = 3000;

class Credentials {}

/// NetworkService client implementation
class NetworkService {
  // Flag is indicating that client is shutting down
  bool _isShutDown = false;

  // gRPC client channel to send messages to the server
  ClientChannel _clientSend;

  // gRPC client channel to receive messages from the server
  ClientChannel _clientReceive;

  grpc.NetworkServiceClient _networkService;

  // Event is raised when message has been sent to the server successfully
  final void Function(Credentials cred) onSentSuccess;

  /// Event is raised when message sending is failed
  final void Function(Credentials message, String error) onSentError;

  /// Event is raised when message has been received from the server
  final void Function() onReceivedSuccess;

  /// Event is raised when message receiving is failed
  final void Function(String error) onReceivedError;

  NetworkService(
      {this.onSentSuccess,
      this.onSentError,
      this.onReceivedError,
      this.onReceivedSuccess});

  // Shutdown client
  Future<void> shutdown() async {
    _isShutDown = true;
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

  // // Try connect to wifi with gRPC call
  // void connect(Credentials cred) async {
  //   if (_clientSend == null) {
  //     // Create new client
  //     _clientSend = ClientChannel(
  //       serverIP,
  //       port: serverPort,
  //       options: ChannelOptions(
  //         credentials: ChannelCredentials.insecure(),
  //         idleTimeout: Duration(seconds: 10),
  //       ),
  //     );
  //     _networkService = grpc.NetworkServiceClient(_clientSend);
  //   }

  //   final c = grpc.WifiCredentials()
  //     ..name = "admin"
  //     ..password = "admin";
  //   await _networkService.connectWifi(c).then().catchError(onError);
  // }
}
