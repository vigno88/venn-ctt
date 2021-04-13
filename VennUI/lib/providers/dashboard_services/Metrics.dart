import 'dart:async';

import 'package:VennUI/components/Grid.dart';
import 'package:VennUI/grpc/metric.dart';
import 'package:VennUI/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:VennUI/grpc/v1/ui.pb.dart' as proto;
import 'package:flutter_icons/flutter_icons.dart';

// Metric serive is used to track data about the metrics
class MetricService {
  // _updates is used to tell the provider which widget needs to be updated
  StreamController<int> _updates;
  Stream<int> get updateStream => _updates.stream;

  // List of tiles provided by metric service, the dashboard provider reads
  // them each time the metric service tells it a tile was modified. This
  // should be the only thing that the dashboard provider has access other than
  // the update stream.
  List<Tile> _tiles = [];
  List<Tile> get tiles => _tiles;

  // isAlert is used as a flag to tell when one of the metric tiles is in alert
  bool isAlert = false;

  // config is constant information about each metric tiles
  List<proto.MetricConfig> config = [];

  // metricTiles is the list of MetricTile widget
  List<MetricTile> metricTiles = [];

  // Configuration and metric service API object
  MetricGrpcAPI _metricAPI;

  MetricService(MetricGrpcAPI m) {
    _metricAPI = m;
    initiate();
  }

  void initiate() async {
    // Get the config from the server
    var c = await _metricAPI.readConfig();
    config = c.configs;

    // Create the set of tile providers
    var m = await _metricAPI.getMetrics();
    for (int i = 0; i < m.updates.length; i++) {
      var t = MetricData(
        m.updates[i].name,
        m.updates[i].value,
        config[0].unit,
        config[0].type,
        config[0].info,
        m.updates[i].target,
        config[0].hasTarget_6,
      );
      metricTiles.add(MetricTile(Key(i.toString()), t, 1.0));
    }
    // notifyListeners();

    // Listen for new metrics from the backend
    var stream = _metricAPI.getMetricStream();
    await for (var metric in stream) {
      processNewMetric(metric);
    }
  }

  void processNewMetric(proto.MetricUpdate update) {
    // Update the required tile
    metricTiles.forEach((tile) {
      if (tile.data.name == update.name) {
        tile.data.update(update);
        // modifiedTileIndex = metricTiles.indexOf(tile);
        // notifyListeners();
      }
    });
    // Look if any tile is in alert
    bool alert = false;
    metricTiles.forEach((tile) {
      // if (tile._isAlert) {
      //   alert = true;
      // }
    });
    // Only notifier listeners if alert state is different from previous
    if (isAlert != alert) {
      isAlert = alert;
      // notifyListeners();
    }
  }
}

class MetricData {
  double _value;
  String _name;
  String _unit;
  String _type;
  String _info;
  double _target;
  Icon _icon;
  bool _hasTarget;
  bool _isAlert;
  double _uncertainty = 2;

  MetricData(
    String name,
    double value,
    String unit,
    String type,
    String info,
    double goal,
    bool hasTarget,
  ) {
    _value = value;
    _name = name;
    _unit = unit;
    _type = type;
    _info = info;
    _target = goal;
    _hasTarget = hasTarget;
    _isAlert = false;
    // Set the right icon for the metric type
    switch (type) {
      case 'Temperature':
        this._icon = Icon(FontAwesome5Solid.thermometer_half);
        break;
      case 'Humidity':
        this._icon = Icon(Ionicons.ios_water);
        break;
      case 'Speed':
        this._icon = Icon(Ionicons.ios_speedometer);
        break;
    }
  }

  double get value => _value;
  String get name => _name;
  String get unit => _unit;
  String get type => _type;
  String get info => _info;
  double get target => _target;
  bool get hasTarget => _hasTarget;
  Icon get icon => _icon;
  bool get isAlert => _isAlert;

  void update(proto.MetricUpdate u) {
    _value = u.value;
    _target = u.target;
    _isAlert = false;
    if (hasTarget &&
        (value < target - _uncertainty || value > target + _uncertainty)) {
      _isAlert = true;
    }
  }
}