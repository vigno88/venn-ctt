///
//  Generated code. Do not modify.
//  source: ui.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const Metric$json = const {
  '1': 'Metric',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
    const {'1': 'average', '3': 3, '4': 1, '5': 1, '10': 'average'},
    const {'1': 'goal', '3': 4, '4': 1, '5': 1, '10': 'goal'},
  ],
};

const Metrics$json = const {
  '1': 'Metrics',
  '2': const [
    const {'1': 'metrics', '3': 1, '4': 3, '5': 11, '6': '.v1.Metric', '10': 'metrics'},
  ],
};

const Setting$json = const {
  '1': 'Setting',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
    const {'1': 'max', '3': 3, '4': 1, '5': 1, '10': 'max'},
    const {'1': 'min', '3': 4, '4': 1, '5': 1, '10': 'min'},
    const {'1': 'name', '3': 5, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'info', '3': 6, '4': 1, '5': 9, '10': 'info'},
    const {'1': 'goalName', '3': 7, '4': 1, '5': 9, '10': 'goalName'},
  ],
};

const Recipe$json = const {
  '1': 'Recipe',
  '2': const [
    const {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
    const {'1': 'settings', '3': 2, '4': 3, '5': 11, '6': '.v1.Setting', '10': 'settings'},
  ],
};

const UUIDS$json = const {
  '1': 'UUIDS',
  '2': const [
    const {'1': 'uuids', '3': 1, '4': 3, '5': 9, '10': 'uuids'},
  ],
};

const Credentials$json = const {
  '1': 'Credentials',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 9, '10': 'user'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

const WifiCredentials$json = const {
  '1': 'WifiCredentials',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

const MetricConfig$json = const {
  '1': 'MetricConfig',
  '2': const [
    const {'1': 'unit', '3': 1, '4': 1, '5': 9, '10': 'unit'},
    const {'1': 'goal', '3': 2, '4': 1, '5': 2, '10': 'goal'},
    const {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'info', '3': 5, '4': 1, '5': 9, '10': 'info'},
    const {'1': 'hasGoal', '3': 6, '4': 1, '5': 8, '10': 'hasGoal'},
  ],
};

const Configuration$json = const {
  '1': 'Configuration',
  '2': const [
    const {'1': 'metricsConfig', '3': 1, '4': 3, '5': 11, '6': '.v1.MetricConfig', '10': 'metricsConfig'},
  ],
};

const Action$json = const {
  '1': 'Action',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'payload', '3': 2, '4': 1, '5': 9, '10': 'payload'},
  ],
};

const ControlEvent$json = const {
  '1': 'ControlEvent',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'payload', '3': 2, '4': 1, '5': 9, '10': 'payload'},
  ],
};

const Empty$json = const {
  '1': 'Empty',
};

const DoubleValue$json = const {
  '1': 'DoubleValue',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 1, '10': 'value'},
  ],
};

const FloatValue$json = const {
  '1': 'FloatValue',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 2, '10': 'value'},
  ],
};

const Int64Value$json = const {
  '1': 'Int64Value',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 3, '10': 'value'},
  ],
};

const UInt64Value$json = const {
  '1': 'UInt64Value',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 4, '10': 'value'},
  ],
};

const Int32Value$json = const {
  '1': 'Int32Value',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 5, '10': 'value'},
  ],
};

const UInt32Value$json = const {
  '1': 'UInt32Value',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 13, '10': 'value'},
  ],
};

const BoolValue$json = const {
  '1': 'BoolValue',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 8, '10': 'value'},
  ],
};

const StringValue$json = const {
  '1': 'StringValue',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 9, '10': 'value'},
  ],
};

const BytesValue$json = const {
  '1': 'BytesValue',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

