import 'package:VennUI/api/configuration_service.dart';
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
  List<MetricTile> metricTiles = List<MetricTile>();

  // Configuration and metric service API object
  ConfigurationService configService;
  MetricService metricService;

  MetricProvider(ConfigurationService c, MetricService m) {
    configService = c;
    metricService = m;
    initiate();
  }

  void initiate() async {
    // Get the config from the server
    var c = await configService.getConfiguration();
    config = c.metricsConfig;

    // Create the set of tile providers
    var m = await metricService.getMetrics();
    for (int i = 0; i < m.metrics.length; i++) {
      var t = MetricTile(
        m.metrics[i].name,
        m.metrics[i].value,
        config[0].unit,
        config[0].type,
        config[0].info,
        m.metrics[i].goal,
        config[0].hasGoal_6,
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

  void processNewMetric(proto.Metric metric) {
    // Update the required tile
    metricTiles.forEach((tile) {
      if (tile.name == metric.name) {
        tile.update(metric);
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
  double _goal;
  Icon _icon;
  bool _hasGoal;
  bool _isAlert;

  MetricTile(
    String name,
    double value,
    String unit,
    String type,
    String info,
    double goal,
    bool hasGoal,
  ) {
    _value = value;
    _name = name;
    _unit = unit;
    _type = type;
    _info = info;
    _goal = goal;
    _hasGoal = hasGoal;
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
  double get goal => _goal;
  bool get hasGoal => _hasGoal;
  Icon get icon => _icon;
  bool get isAlert => _isAlert;

  void update(proto.Metric m) {
    _value = m.value;
    _goal = m.goal;
    _isAlert = false;
    if (hasGoal && (value < goal - 2 || value > goal + 2)) {
      _isAlert = true;
    }
  }
}
