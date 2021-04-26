import 'dart:async';

import 'package:VennUI/components/Notification.dart';
import 'package:VennUI/grpc/utilities.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:VennUI/grpc/v1/ui.pb.dart' as proto;
import 'package:VennUI/grpc/v1/ui.pbgrpc.dart' as grpc;
import 'package:VennUI/utilies.dart';

class ControlGrpcAPI {
  // Flag is indicating that client is shutting down
  bool _isShutdown = false;

  // gRPC client channel to send messages to the server
  ClientChannel _clientSend;

  // gRPC client channel to receive messages from the server
  ClientChannel _clientReceive;

  StreamController<NotificationData> _notifStream;

  ControlGrpcAPI(StreamController<NotificationData> stream) {
    _clientSend = newClient(serverIP, serverPort);
    _notifStream = stream;
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

  Stream<proto.ControlEvent> getEventStream() async* {
    if (_clientSend == null) {
      _clientSend = newClient(serverIP, serverPort);
    }
    try {
      var request = proto.Empty().createEmptyInstance();
      var stream =
          await grpc.ControlServiceClient(_clientSend).subscribe(request);
      await for (proto.ControlEvent m in stream) {
        yield m;
      }
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();
        print(e.toString());
        // Try again
        Future.delayed(retryDelay, () {
          return getEventStream();
        });
      }
    }
  }

  // Asynchronous function to read the list of user from the backend
  void send(BuildContext context, proto.Action a) async {
    if (_clientSend == null) {
      _clientSend = newClient(serverIP, serverPort);
    }
    try {
      proto.SendResponse response =
          await grpc.ControlServiceClient(_clientSend).send(a);
      if (response.error != "") {
        print(response.error);
        _notifStream
            .add(NotificationData(NotificationType.Warning, response.error));
        print("Added a notif to the stream");
        // context.read()<NotificationProvider>().displayNotification(
        //     NotificationData(NotificationType.Warning, response.error));
      }
    } catch (e) {
      if (!_isShutdown) {
        // Invalidate current client
        _shutdownSend();
        print(e.toString());
        // Try again
        Future.delayed(retryDelay, () {
          return send(context, a);
        });
      }
    }
  }
}
