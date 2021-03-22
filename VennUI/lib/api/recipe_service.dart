import 'package:grpc/grpc.dart';
import 'package:VennUI/api/v1/ui.pbgrpc.dart' as grpc;
import 'package:VennUI/api/v1/ui.pb.dart' as proto;
import 'package:VennUI/utilies.dart';

const serverPort = 3000;

class Credentials {}

/// RecipeService client implementation
class RecipeService {
  // Flag is indicating that client is shutting down
  bool _isShutdown = false;

  // gRPC client channel to send messages to the server
  ClientChannel _clientSend;

  // grpc.MetricServiceClient _metricService;

  // // Event is raised when message has been sent to the server successfully
  // final void Function(Credentials cred) onSentSuccess;

  // /// Event is raised when message sending is failed
  // final void Function(Credentials message, String error) onSentError;

  // /// Event is raised when message has been received from the server
  // final void Function() onReceivedSuccess;

  // /// Event is raised when message receiving is failed
  // final void Function(String error) onReceivedError;

  // NetworkService(
  //     {this.onSentSuccess,
  //     this.onSentError,
  //     this.onReceivedError,
  //     this.onReceivedSuccess});

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

// Asynchronous function to set a setting in the backend
  void setSetting(proto.Setting s) async {
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
      await grpc.SettingServiceClient(_clientSend).setSetting(s);
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();

        // Print the error
        print(e.toString());

        // Try again
        Future.delayed(Duration(milliseconds: 100), () {
          return setSetting(s);
        });
      }
    }
  }

  // Asynchronous function get UUIDS of recipe in the backend
  Future<proto.UUIDS> getUUIDS() async {
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
      var empty = grpc.Empty.create();
      return grpc.SettingServiceClient(_clientSend).getRecipesUUID(empty);
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();

        // Print the error
        print(e.toString());

        // Try again
        Future.delayed(Duration(milliseconds: 100), () {
          return getUUIDS();
        });
      }
    }
  }

  // Asynchronous function get a recipe from the backend
  Future<proto.Recipe> getRecipe(String uuid) async {
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
      var request = grpc.StringValue(value: uuid);
      return grpc.SettingServiceClient(_clientSend).getRecipe(request);
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();

        // Print the error
        print(e.toString());

        // Try again
        Future.delayed(Duration(milliseconds: 100), () {
          return getRecipe(uuid);
        });
      }
    }
  }

  // Asynchronous function get a recipe from the backend
  Future<proto.Recipe> createRecipe() async {
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
      var request = grpc.Empty.create();
      return grpc.SettingServiceClient(_clientSend).createRecipe(request);
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();

        // Print the error
        print(e.toString());

        // Try again
        Future.delayed(Duration(milliseconds: 100), () {
          return createRecipe();
        });
      }
    }
  }

  // Asynchronous function get a recipe from the backend
  void selectRecipe(String uuid) async {
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
      var request = grpc.StringValue(value: uuid);
      await grpc.SettingServiceClient(_clientSend).selectRecipe(request);
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();

        // Print the error
        print(e.toString());

        // Try again
        Future.delayed(Duration(milliseconds: 100), () {
          selectRecipe(uuid);
        });
      }
    }
  }
}
