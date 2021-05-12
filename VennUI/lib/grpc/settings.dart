import 'package:grpc/grpc.dart';
import 'package:VennUI/grpc/v1/ui.pbgrpc.dart' as grpc;
import 'package:VennUI/grpc/v1/ui.pb.dart' as proto;
import 'package:VennUI/utilies.dart';

import 'utilities.dart';

class Credentials {}

class SettingGrpcAPI {
  // Flag is indicating that client is shutting down
  bool _isShutdown = false;

  // gRPC client channel to send messages to the server
  ClientChannel _clientSend;

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

  // Asynchronous function to Update a setting in the backend
  void updateSetting(proto.SettingUpdate s) async {
    if (_clientSend == null) {
      _clientSend = newClient(serverIP, serverPort);
    }
    try {
      await grpc.SettingServiceClient(_clientSend).updateSetting(s);
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();
        print(e.toString());
        // Try again
        Future.delayed(retryDelay, () {
          return updateSetting(s);
        });
      }
    }
  }

  // Asynchronous function to update the uncertainty on a setting target
  void updateUncertainty(proto.TargetUpdate u) async {
    if (_clientSend == null) {
      _clientSend = newClient(serverIP, serverPort);
    }
    try {
      await grpc.SettingServiceClient(_clientSend).updateUncertainty(u);
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();
        print(e.toString());
        // Try again
        Future.delayed(retryDelay, () {
          return updateUncertainty(u);
        });
      }
    }
  }

  // Asynchronous function to Update the selected choice of a selector
  void updateSelectedChoice(proto.SelectorUpdate u) async {
    if (_clientSend == null) {
      _clientSend = newClient(serverIP, serverPort);
    }
    try {
      await grpc.SettingServiceClient(_clientSend).updateSelectedChoice(u);
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();
        print(e.toString());
        // Try again
        Future.delayed(retryDelay, () {
          return updateSelectedChoice(u);
        });
      }
    }
  }

  // Asynchronous function to update a choice settings
  void updateChoice(proto.ChoiceUpdate u) async {
    if (_clientSend == null) {
      _clientSend = newClient(serverIP, serverPort);
    }
    try {
      await grpc.SettingServiceClient(_clientSend).updateChoice(u);
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();
        print(e.toString());
        // Try again
        Future.delayed(retryDelay, () {
          return updateChoice(u);
        });
      }
    }
  }

  // Asynchronous function read UUIDS of recipes in the backend
  Future<proto.UUIDS> readRecipesUUID() async {
    if (_clientSend == null) {
      // Create a new client
      _clientSend = newClient(serverIP, serverPort);
    }

    try {
      var empty = grpc.Empty.create();
      return grpc.SettingServiceClient(_clientSend).readRecipesUUID(empty);
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();

        // Print the error
        print(e.toString());

        // Try again
        Future.delayed(retryDelay, () {
          return readRecipesUUID();
        });
      }
    }
  }

  // Asynchronous function read a recipe from the backend
  Future<proto.Recipe> readRecipe(String uuid) async {
    if (_clientSend == null) {
      _clientSend = newClient(serverIP, serverPort);
    }
    try {
      var request = grpc.StringValue(value: uuid);
      return grpc.SettingServiceClient(_clientSend).readRecipe(request);
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();
        print(e.toString());
        // Try again
        Future.delayed(retryDelay, () {
          return readRecipe(uuid);
        });
      }
    }
  }

  // Asynchronous function read a recipe from the backend
  Future<proto.Recipe> readCurrentRecipe() async {
    if (_clientSend == null) {
      _clientSend = newClient(serverIP, serverPort);
    }
    try {
      return grpc.SettingServiceClient(_clientSend)
          .readCurrentRecipe(grpc.Empty());
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();
        print(e.toString());
        // Try again
        Future.delayed(retryDelay, () {
          return readCurrentRecipe();
        });
      }
    }
  }

  // Asynchronous function get a recipe from the backend
  Future<proto.Recipe> createRecipe() async {
    if (_clientSend == null) {
      _clientSend = newClient(serverIP, serverPort);
    }
    try {
      var request = grpc.Empty.create();
      return grpc.SettingServiceClient(_clientSend).createRecipe(request);
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();
        print(e.toString());
        // Try again
        Future.delayed(retryDelay, () {
          return createRecipe();
        });
      }
    }
  }

  // Asynchronous function to update the current recipe from the backend
  void updateCurrentRecipe(String uuid) async {
    if (_clientSend == null) {
      _clientSend = newClient(serverIP, serverPort);
    }
    try {
      var request = grpc.StringValue(value: uuid);
      await grpc.SettingServiceClient(_clientSend).updateCurrentRecipe(request);
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();
        print(e.toString());
        // Try again
        Future.delayed(retryDelay, () {
          return updateCurrentRecipe(uuid);
        });
      }
    }
  }

  // Asynchronous function to update a recipe in the backend
  void updateRecipe(proto.Recipe r) async {
    if (_clientSend == null) {
      _clientSend = newClient(serverIP, serverPort);
    }
    try {
      await grpc.SettingServiceClient(_clientSend).updateRecipe(r);
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();
        print(e.toString());
        // Try again
        Future.delayed(retryDelay, () {
          return updateRecipe(r);
        });
      }
    }
  }

  // Asynchronous function to update a recipe in the backend
  void deleteRecipe(String uuid) async {
    if (_clientSend == null) {
      _clientSend = newClient(serverIP, serverPort);
    }
    try {
      await grpc.SettingServiceClient(_clientSend)
          .deleteRecipe(grpc.StringValue(value: uuid));
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();
        print(e.toString());
        // Try again
        Future.delayed(retryDelay, () {
          return deleteRecipe(uuid);
        });
      }
    }
  }

  Future<proto.Selectors> readSelectorList() async {
    if (_clientSend == null) {
      _clientSend = newClient(serverIP, serverPort);
    }
    try {
      var request = grpc.Empty.create();
      var selectors = await grpc.SettingServiceClient(_clientSend)
          .readSelectorList(request);
      return selectors;
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();
        print(e.toString());
        // Try again
        Future.delayed(retryDelay, () {
          return readSelectorList();
        });
      }
    }
  }
}
