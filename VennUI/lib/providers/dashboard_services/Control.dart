import 'dart:async';

import 'package:VennUI/components/ActionButton.dart';
import 'package:VennUI/components/Grid.dart';
import 'package:VennUI/grpc/control.dart';
import 'package:flutter/material.dart';
import 'package:VennUI/grpc/v1/ui.pb.dart' as proto;

class ControlService with ChangeNotifier {
  // _updates is used to tell the provider which widget needs to be updated
  StreamController<int> _updates;
  Stream<int> get updateStream => _updates.stream;

  // List of tiles provided by control service, the dashboard provider reads
  // them each time the control service tells it a tile was modified. This
  // should be the only thing that the dashboard provider has access other than
  // the update stream.
  List<Tile> _tiles = [];
  List<Tile> get tiles => _tiles;

  ControlGrpcAPI _controlAPI;

  List<ActionButton> buttonsState1 = [];
  List<ActionButton> buttonsState2 = [];

  ControlService(ControlGrpcAPI s) {
    _controlAPI = s;
    _updates = StreamController();
  }

  void initiate() async {
    buttonsState1 = [
      ActionButton("Pistons 1", "OPEN", () {
        _controlAPI.send(proto.Action(name: "p1", payload: "open"));
      }),
      ActionButton("Pistons 2", "OPEN", () {
        _controlAPI.send(proto.Action(name: "p2", payload: "open"));
      }),
      ActionButton("Pistons 3", "OPEN", () {
        _controlAPI.send(proto.Action(name: "p3", payload: "open"));
      }),
      ActionButton("Pistons 4", "OPEN", () {
        _controlAPI.send(proto.Action(name: "p4", payload: "open"));
      }),
      ActionButton("Pistons 5", "OPEN", () {
        _controlAPI.send(proto.Action(name: "p5", payload: "open"));
      }),
      ActionButton("Pistons 6", "OPEN", () {
        _controlAPI.send(proto.Action(name: "p6", payload: "open"));
      }),
      ActionButton("All Pistons", "OPEN", () {
        _controlAPI.send(proto.Action(name: "ps", payload: "open"));
      }),
      ActionButton("Home", "START", () {
        _controlAPI.send(proto.Action(name: "home", payload: "start"));
      }),
      ActionButton("Cycle", "START", () {
        _controlAPI.send(proto.Action(name: "cycle", payload: "start"));
      }),
      ActionButton("Water", "START", () {
        _controlAPI.send(proto.Action(name: "water", payload: "start"));
      }),
    ];

    buttonsState2 = [
      ActionButton("Pistons 1", "CLOSE", () {
        _controlAPI.send(proto.Action(name: "p1", payload: "close"));
      }),
      ActionButton("Pistons 2", "CLOSE", () {
        _controlAPI.send(proto.Action(name: "p2", payload: "close"));
      }),
      ActionButton("Pistons 3", "CLOSE", () {
        _controlAPI.send(proto.Action(name: "p3", payload: "close"));
      }),
      ActionButton("Pistons 4", "CLOSE", () {
        _controlAPI.send(proto.Action(name: "p4", payload: "close"));
      }),
      ActionButton("Pistons 5", "CLOSE", () {
        _controlAPI.send(proto.Action(name: "p5", payload: "close"));
      }),
      ActionButton("Pistons 6", "CLOSE", () {
        _controlAPI.send(proto.Action(name: "p6", payload: "close"));
      }),
      ActionButton("All Pistons", "CLOSE", () {
        _controlAPI.send(proto.Action(name: "ps", payload: "close"));
      }),
      ActionButton("Home", "START", () {
        _controlAPI.send(proto.Action(name: "home", payload: "start"));
      }),
      ActionButton("Cycle", "STOP", () {
        _controlAPI.send(proto.Action(name: "cycle", payload: "stop"));
      }),
      ActionButton("Water", "STOP", () {
        _controlAPI.send(proto.Action(name: "water", payload: "stop"));
      }),
    ];
  }
}
