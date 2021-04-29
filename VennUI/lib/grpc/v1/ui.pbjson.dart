///
//  Generated code. Do not modify.
//  source: ui.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const MetricConfig$json = const {
  '1': 'MetricConfig',
  '2': const [
    const {'1': 'unit', '3': 1, '4': 1, '5': 9, '10': 'unit'},
    const {'1': 'target', '3': 2, '4': 1, '5': 2, '10': 'target'},
    const {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'info', '3': 5, '4': 1, '5': 9, '10': 'info'},
    const {'1': 'hasTarget', '3': 6, '4': 1, '5': 8, '10': 'hasTarget'},
    const {'1': 'smallName', '3': 7, '4': 1, '5': 9, '10': 'smallName'},
  ],
};

const MetricConfigs$json = const {
  '1': 'MetricConfigs',
  '2': const [
    const {'1': 'configs', '3': 1, '4': 3, '5': 11, '6': '.v1.MetricConfig', '10': 'configs'},
  ],
};

const MetricUpdate$json = const {
  '1': 'MetricUpdate',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
    const {'1': 'target', '3': 3, '4': 1, '5': 1, '10': 'target'},
  ],
};

const MetricUpdates$json = const {
  '1': 'MetricUpdates',
  '2': const [
    const {'1': 'updates', '3': 1, '4': 3, '5': 11, '6': '.v1.MetricUpdate', '10': 'updates'},
  ],
};

const Setting$json = const {
  '1': 'Setting',
  '2': const [
    const {'1': 'destination', '3': 1, '4': 1, '5': 14, '6': '.v1.Setting.Destination', '10': 'destination'},
    const {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
    const {'1': 'max', '3': 3, '4': 1, '5': 1, '10': 'max'},
    const {'1': 'min', '3': 4, '4': 1, '5': 1, '10': 'min'},
    const {'1': 'name', '3': 5, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'info', '3': 6, '4': 1, '5': 9, '10': 'info'},
    const {'1': 'target', '3': 7, '4': 1, '5': 11, '6': '.v1.Target', '10': 'target'},
    const {'1': 'smallName', '3': 8, '4': 1, '5': 9, '10': 'smallName'},
  ],
  '4': const [Setting_Destination$json],
};

const Setting_Destination$json = const {
  '1': 'Destination',
  '2': const [
    const {'1': 'NONE', '2': 0},
    const {'1': 'MOTOR', '2': 1},
    const {'1': 'MICROCONTROLLER', '2': 2},
  ],
};

const Target$json = const {
  '1': 'Target',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'uncertainty', '3': 2, '4': 1, '5': 1, '10': 'uncertainty'},
  ],
};

const SettingUpdate$json = const {
  '1': 'SettingUpdate',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
};

const TargetUpdate$json = const {
  '1': 'TargetUpdate',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
};

const Choice$json = const {
  '1': 'Choice',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'settings', '3': 2, '4': 3, '5': 11, '6': '.v1.Setting', '10': 'settings'},
  ],
};

const Selector$json = const {
  '1': 'Selector',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'selectedChoice', '3': 2, '4': 1, '5': 11, '6': '.v1.Choice', '10': 'selectedChoice'},
    const {'1': 'possibleChoices', '3': 3, '4': 3, '5': 11, '6': '.v1.Choice', '10': 'possibleChoices'},
  ],
};

const Selectors$json = const {
  '1': 'Selectors',
  '2': const [
    const {'1': 'selectors', '3': 1, '4': 3, '5': 11, '6': '.v1.Selector', '10': 'selectors'},
  ],
};

const SelectorUpdate$json = const {
  '1': 'SelectorUpdate',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'choiceName', '3': 2, '4': 1, '5': 9, '10': 'choiceName'},
  ],
};

const ChoiceUpdate$json = const {
  '1': 'ChoiceUpdate',
  '2': const [
    const {'1': 'nameSelector', '3': 1, '4': 1, '5': 9, '10': 'nameSelector'},
    const {'1': 'newChoice', '3': 2, '4': 1, '5': 11, '6': '.v1.Choice', '10': 'newChoice'},
  ],
};

const Recipe$json = const {
  '1': 'Recipe',
  '2': const [
    const {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'info', '3': 3, '4': 1, '5': 9, '10': 'info'},
    const {'1': 'settings', '3': 4, '4': 3, '5': 11, '6': '.v1.Setting', '10': 'settings'},
    const {'1': 'selectors', '3': 5, '4': 3, '5': 11, '6': '.v1.Selector', '10': 'selectors'},
  ],
};

const UUIDS$json = const {
  '1': 'UUIDS',
  '2': const [
    const {'1': 'uuids', '3': 1, '4': 3, '5': 9, '10': 'uuids'},
  ],
};

const User$json = const {
  '1': 'User',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'role', '3': 2, '4': 1, '5': 14, '6': '.v1.User.Roles', '10': 'role'},
  ],
  '4': const [User_Roles$json],
};

const User_Roles$json = const {
  '1': 'Roles',
  '2': const [
    const {'1': 'USER', '2': 0},
    const {'1': 'ADMIN', '2': 1},
    const {'1': 'CREATOR', '2': 2},
  ],
};

const Users$json = const {
  '1': 'Users',
  '2': const [
    const {'1': 'users', '3': 1, '4': 3, '5': 11, '6': '.v1.User', '10': 'users'},
  ],
};

const WifiCredentials$json = const {
  '1': 'WifiCredentials',
  '2': const [
    const {'1': 'SSID', '3': 1, '4': 1, '5': 9, '10': 'SSID'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

const WifiNames$json = const {
  '1': 'WifiNames',
  '2': const [
    const {'1': 'SSIDs', '3': 1, '4': 3, '5': 9, '10': 'SSIDs'},
  ],
};

const WifiStatus$json = const {
  '1': 'WifiStatus',
  '2': const [
    const {'1': 'isConnected', '3': 1, '4': 1, '5': 8, '10': 'isConnected'},
    const {'1': 'SSID', '3': 2, '4': 1, '5': 9, '10': 'SSID'},
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

const SendResponse$json = const {
  '1': 'SendResponse',
  '2': const [
    const {'1': 'error', '3': 1, '4': 1, '5': 9, '10': 'error'},
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

