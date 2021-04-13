import 'package:VennUI/grpc/utilities.dart';
import 'package:grpc/grpc.dart';
import 'package:VennUI/grpc/v1/ui.pbgrpc.dart' as grpc;
import 'package:VennUI/grpc/v1/ui.pb.dart' as proto;
import 'package:VennUI/utilies.dart';

class MetricGrpcAPI {
  // Flag is indicating that client is shutting down
  bool _isShutdown = false;

  // gRPC client channel to send messages to the server
  ClientChannel _clientSend;

  // gRPC client channel to receive messages from the server
  ClientChannel _clientReceive;

  MetricGrpcAPI() {
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

// Asynchronous function to get the current metrics from the server
  Future<proto.MetricUpdates> getMetrics() async {
    if (_clientSend == null) {
      _clientSend = newClient(serverIP, serverPort);
    }

    var request = grpc.Empty().createEmptyInstance();

    try {
      var metrics = await grpc.MetricServiceClient(_clientSend).getAll(request);
      return metrics;
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();
        print(e.toString());
        // Try again
        Future.delayed(retryDelay, () {
          return getMetrics();
        });
      }
    }
  }

  // Asynchronous function to get the current metrics configuration from the server
  Future<proto.MetricConfigs> readConfig() async {
    if (_clientSend == null) {
      _clientSend = newClient(serverIP, serverPort);
    }

    var request = grpc.Empty().createEmptyInstance();

    try {
      var configs =
          await grpc.MetricServiceClient(_clientSend).readConfig(request);
      return configs;
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();
        print(e.toString());
        // Try again
        Future.delayed(retryDelay, () {
          return readConfig();
        });
      }
    }
  }

  // Asynchronous function to update the current metrics configuration from the server
  void updateConfig(proto.MetricConfigs c) async {
    if (_clientSend == null) {
      _clientSend = newClient(serverIP, serverPort);
    }
    try {
      await grpc.MetricServiceClient(_clientSend).updateConfig(c);
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();
        print(e.toString());
        // Try again
        Future.delayed(retryDelay, () {
          return updateConfig(c);
        });
      }
    }
  }

  // Asynchronous function to get the stream of metrics from the server
  Stream<proto.MetricUpdate> getMetricStream() async* {
    if (_clientReceive == null) {
      _clientReceive = newClient(serverIP, serverPort);
    }

    var request = grpc.Empty().createEmptyInstance();

    try {
      var stream = grpc.MetricServiceClient(_clientReceive).subscribe(request);
      await for (proto.MetricUpdates M in stream) {
        for (var m in M.updates) {
          yield m;
        }
      }
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();
        // Print the error
        print(e.toString());
        Future.delayed(retryDelay, () {
          return getMetricStream();
        });
      }
    }
  }
}
