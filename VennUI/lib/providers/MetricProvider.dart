import 'package:VennUI/api/metric_service.dart';
import 'package:flutter/material.dart';
import 'package:VennUI/api/v1/ui.pb.dart' as proto;
import 'package:typicons_flutter/typicons_flutter.dart';

// Metric provider is used to track data about the metric dashboard
class MetricProvider with ChangeNotifier {
  // isLoading is used as a flag to tell when loading of initial data is done
  bool isLoading = true;

  // isAlert is used as a flag to tell when one of the metric tiles is in alert
  bool isAlert = false;

  // modifiedTile is used to compare during widget tree rebuilding to rebuild
  // only the tile that has been modified
  int modifiedTileIndex = 0;

  // config is constant information about each metric tiles
  List<proto.MetricConfig> config = [];

  // metricTiles is the list of MetricTile widget
  List<MetricTile> metricTiles = [];

  // Configuration and metric service API object
  MetricService metricService;

  MetricProvider(MetricService m) {
    metricService = m;
    initiate();
  }

  void initiate() async {
    // Get the config from the server
    var c = await metricService.readConfig();
    config = c.configs;

    // Create the set of tile providers
    var m = await metricService.getMetrics();
    for (int i = 0; i < m.updates.length; i++) {
      var t = MetricTile(
        m.updates[i].name,
        m.updates[i].value,
        config[0].unit,
        config[0].type,
        config[0].info,
        m.updates[i].target,
        config[0].hasTarget_6,
      );
      metricTiles.add(t);
    }
    isLoading = false;
    notifyListeners();

    // Listen for new metrics from the backend
    var stream = metricService.getMetricStream();
    await for (var metric in stream) {
      processNewMetric(metric);
    }
  }

  void processNewMetric(proto.MetricUpdate update) {
    // Update the required tile
    metricTiles.forEach((tile) {
      if (tile.name == update.name) {
        tile.update(update);
        modifiedTileIndex = metricTiles.indexOf(tile);
        notifyListeners();
      }
    });
    // Look if any tile is in alert
    bool alert = false;
    metricTiles.forEach((tile) {
      if (tile._isAlert) {
        alert = true;
      }
    });
    // Only notifier listeners if alert state is different from previous
    if (isAlert != alert) {
      isAlert = alert;
      notifyListeners();
    }
  }
}

class MetricTile {
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

  MetricTile(
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
      case 'temperature':
        this._icon = Icon(Typicons.thermometer);
        break;
      case 'humidity':
        this._icon = Icon(Typicons.weather_shower);
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
