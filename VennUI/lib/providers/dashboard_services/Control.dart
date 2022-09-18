import 'dart:async';

import 'package:VennUI/components/ActionButton.dart';
import 'package:VennUI/components/Grid.dart';
import 'package:VennUI/grpc/control.dart';
import 'package:VennUI/grpc/v1/ui.pb.dart' as proto;
import 'package:VennUI/providers/NotificationProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ControlService {
  // _updates is used to tell the provider which widget needs to be updated
  StreamController<int> _updates = StreamController<int>();
  Stream<int> get updateStream => _updates.stream;

  List<ButtonData> buttonsData = [
    ButtonData("Pistons 1", [
      "CLOSE",
      "OPEN"
    ], [
      proto.Action(name: "piston", payload: "pi#1#close"),
      proto.Action(name: "piston", payload: "pi#1#open")
    ]),
    ButtonData("Pistons 2", [
      "CLOSE",
      "OPEN"
    ], [
      proto.Action(name: "piston", payload: "pi#2#close"),
      proto.Action(name: "piston", payload: "pi#2#open")
    ]),
    ButtonData("Pistons 3", [
      "CLOSE",
      "OPEN"
    ], [
      proto.Action(name: "piston", payload: "pi#3#close"),
      proto.Action(name: "piston", payload: "pi#3#open")
    ]),
    ButtonData("Pistons 4", [
      "CLOSE",
      "OPEN"
    ], [
      proto.Action(name: "piston", payload: "pi#4#close"),
      proto.Action(name: "piston", payload: "pi#4#open")
    ]),
    ButtonData("Pistons 5", [
      "CLOSE",
      "OPEN"
    ], [
      proto.Action(name: "piston", payload: "pi#5#close"),
      proto.Action(name: "piston", payload: "pi#5#open")
    ]),
    ButtonData("Pistons 6", [
      "CLOSE",
      "OPEN"
    ], [
      proto.Action(name: "piston", payload: "pi#6#close"),
      proto.Action(name: "piston", payload: "pi#6#open")
    ]),
    ButtonData("All Pistons", [
      "CLOSE",
      "OPEN"
    ], [
      proto.Action(name: "piston", payload: "pi#s#close"),
      proto.Action(name: "piston", payload: "pi#s#open")
    ]),
    ButtonData("Home", [
      "START",
      "START"
    ], [
      proto.Action(name: "home", payload: "start"),
      proto.Action(name: "home", payload: "start")
    ]),
    ButtonData("Cycle", [
      "START",
      "STOP"
    ], [
      proto.Action(name: "cycle", payload: "start"),
      proto.Action(name: "cycle", payload: "stop")
    ]),
    ButtonData("Water", [
      "START",
      "STOP"
    ], [
      proto.Action(name: "water", payload: "w#start"),
      proto.Action(name: "water", payload: "w#stop")
    ]),
  ];

  List<Tile> tiles = [];

  ControlGrpcAPI _controlAPI;

  ControlService(ControlGrpcAPI s) {
    _controlAPI = s;
    _updates = StreamController();
  }

  void initiate() async {
    // TODO - read button config from grpc API
  }

  // TODO - getTiles is hardcoded for now but it should be configure by a
  // config received on te GRPC API
  List<Tile> getTiles() {
    return [
      Tile(
          ControlContainer([
            ActionButton(buttonsData[0].title,
                buttonsData[0].texts[buttonsData[0].state], 0, 0),
            ActionButton(buttonsData[1].title,
                buttonsData[1].texts[buttonsData[1].state], 1, 0),
            ActionButton(buttonsData[2].title,
                buttonsData[2].texts[buttonsData[2].state], 2, 0),
            ActionButton(buttonsData[3].title,
                buttonsData[3].texts[buttonsData[3].state], 3, 0),
            ActionButton(buttonsData[4].title,
                buttonsData[4].texts[buttonsData[4].state], 4, 0),
            ActionButton(buttonsData[5].title,
                buttonsData[5].texts[buttonsData[5].state], 5, 0),
            ActionButton(buttonsData[6].title,
                buttonsData[6].texts[buttonsData[6].state], 6, 0),
          ]),
          false,
          4,
          2),
      Tile(
          ControlContainer(
            [
              ActionButton(buttonsData[7].title,
                  buttonsData[7].texts[buttonsData[7].state], 7, 1),
              ActionButton(buttonsData[8].title,
                  buttonsData[8].texts[buttonsData[8].state], 8, 1),
            ],
          ),
          false,
          1,
          2),
      Tile(
          ControlContainer([
            ActionButton(buttonsData[9].title,
                buttonsData[9].texts[buttonsData[9].state], 9, 2),
          ]),
          false,
          1,
          1),
    ];
  }

  void pressButton(BuildContext context, int buttonIndex, int tileIndex) async {
    // Send the button press to the API
    await _controlAPI.send(context,
        buttonsData[buttonIndex].actions[buttonsData[buttonIndex].state]);
    // Switch the button data to the other state
    buttonsData[buttonIndex].switchState();
    // Send the update to the dashboard provider
    _updates.add(tileIndex);
  }
}

class ButtonData {
  // state is tell which information to use for the button to be displayed
  int state = 0;
  String title;
  List<String> texts = [];
  List<proto.Action> actions = [];

  ButtonData(this.title, this.texts, this.actions);

  void switchState() {
    if (state == 0) {
      state = 1;
    } else {
      state = 0;
    }
  }
}
