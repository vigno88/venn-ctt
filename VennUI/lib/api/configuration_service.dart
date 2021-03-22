import 'package:grpc/grpc.dart';
import 'package:VennUI/api/v1/ui.pbgrpc.dart' as grpc;
import 'package:VennUI/api/v1/ui.pb.dart' as proto;
import 'package:VennUI/utilies.dart';

const serverPort = 3000;

/// ConfigurationService client implementation
class ConfigurationService {
  /// Flag is indicating that client is shutting down
  bool _isShutdown = false;

  /// gRPC client channel to send messages to the server
  ClientChannel _clientSend;

  // Contstructor
  ConfigurationService() {
    // Create a new client
    _clientSend = ClientChannel(
      serverIP,
      port: serverPort,
      options: ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        idleTimeout: Duration(hours: 24),
      ),
    );
  }

  // Shutdown client
  Future<void> shutdown() async {
    _isShutdown = true;
    _shutdownSend();
  }

  // Shutdown client (send channel)
  void _shutdownSend() {
    if (_clientSend != null) {
      _clientSend.shutdown();
      _clientSend = null;
    }
  }

  // Asynchronous function to get configuration from the server
  Future<proto.Configuration> getConfiguration() async {
    if (_clientSend == null) {
      // Create a new client
      _clientSend = ClientChannel(
        serverIP,
        port: serverPort,
        options: ChannelOptions(
          credentials: ChannelCredentials.insecure(),
          idleTimeout: Duration(hours: 24),
        ),
      );
    }

    var request = grpc.Empty().createEmptyInstance();

    try {
      var config =
          await grpc.ConfigurationServiceClient(_clientSend).getConfig(request);
      return config;
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();

        // Print the error
        print(e.toString());

        // Try again
        Future.delayed(Duration(milliseconds: 100), () {
          return getConfiguration();
        });
      }
    }
  }

  void setConfiguration(proto.Configuration config) {
    if (_clientSend == null) {
      // Create a new client
      _clientSend = ClientChannel(
        serverIP,
        port: serverPort,
        options: ChannelOptions(
          credentials: ChannelCredentials.insecure(),
          idleTimeout: Duration(hours: 24),
        ),
      );
    }

    try {
      grpc.ConfigurationServiceClient(_clientSend).setConfig(config);
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();

        // Print the error
        print(e.toString());

        // Try again
        Future.delayed(Duration(milliseconds: 100), () {
          return getConfiguration();
        });
      }
    }
  }
}
