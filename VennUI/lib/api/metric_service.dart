import 'package:grpc/grpc.dart';
import 'package:VennUI/api/v1/ui.pbgrpc.dart' as grpc;
import 'package:VennUI/api/v1/ui.pb.dart' as proto;
import 'package:VennUI/utilies.dart';

const serverPort = 3000;

class Credentials {}

/// MetricService client implementation
class MetricService {
  // Flag is indicating that client is shutting down
  bool _isShutdown = false;

  // gRPC client channel to send messages to the server
  ClientChannel _clientSend;

  // gRPC client channel to receive messages from the server
  ClientChannel _clientReceive;

  // Constructor
  MetricService() {
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
  Future<proto.Metrics> getMetrics() async {
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
      var metrics = await grpc.MetricServiceClient(_clientSend).get(request);
      return metrics;
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();

        // Print the error
        print(e.toString());

        // Try again
        Future.delayed(Duration(milliseconds: 100), () {
          return getMetrics();
        });
      }
    }
  }

  // Asynchronous function to get the stream of metrics from the server
  Stream<proto.Metric> getMetricStream() async* {
    if (_clientReceive == null) {
      // Create a new client
      _clientReceive = ClientChannel(
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
      var stream = grpc.MetricServiceClient(_clientReceive).subscribe(request);
      await for (proto.Metrics M in stream) {
        for (var m in M.metrics) {
          yield m;
        }
      }
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();

        // Print the error
        print(e.toString());

        // Try again
        Future.delayed(Duration(milliseconds: 100), () {
          return getMetricStream();
        });
      }
    }
  }
}
