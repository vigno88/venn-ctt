///
//  Generated code. Do not modify.
//  source: ui.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use metricConfigDescriptor instead')
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

/// Descriptor for `MetricConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List metricConfigDescriptor = $convert.base64Decode('CgxNZXRyaWNDb25maWcSEgoEdW5pdBgBIAEoCVIEdW5pdBIWCgZ0YXJnZXQYAiABKAJSBnRhcmdldBISCgR0eXBlGAMgASgJUgR0eXBlEhIKBG5hbWUYBCABKAlSBG5hbWUSEgoEaW5mbxgFIAEoCVIEaW5mbxIcCgloYXNUYXJnZXQYBiABKAhSCWhhc1RhcmdldBIcCglzbWFsbE5hbWUYByABKAlSCXNtYWxsTmFtZQ==');
@$core.Deprecated('Use metricConfigsDescriptor instead')
const MetricConfigs$json = const {
  '1': 'MetricConfigs',
  '2': const [
    const {'1': 'configs', '3': 1, '4': 3, '5': 11, '6': '.v1.MetricConfig', '10': 'configs'},
  ],
};

/// Descriptor for `MetricConfigs`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List metricConfigsDescriptor = $convert.base64Decode('Cg1NZXRyaWNDb25maWdzEioKB2NvbmZpZ3MYASADKAsyEC52MS5NZXRyaWNDb25maWdSB2NvbmZpZ3M=');
@$core.Deprecated('Use metricUpdateDescriptor instead')
const MetricUpdate$json = const {
  '1': 'MetricUpdate',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
    const {'1': 'target', '3': 3, '4': 1, '5': 1, '10': 'target'},
  ],
};

/// Descriptor for `MetricUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List metricUpdateDescriptor = $convert.base64Decode('CgxNZXRyaWNVcGRhdGUSEgoEbmFtZRgBIAEoCVIEbmFtZRIUCgV2YWx1ZRgCIAEoAVIFdmFsdWUSFgoGdGFyZ2V0GAMgASgBUgZ0YXJnZXQ=');
@$core.Deprecated('Use metricUpdatesDescriptor instead')
const MetricUpdates$json = const {
  '1': 'MetricUpdates',
  '2': const [
    const {'1': 'updates', '3': 1, '4': 3, '5': 11, '6': '.v1.MetricUpdate', '10': 'updates'},
  ],
};

/// Descriptor for `MetricUpdates`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List metricUpdatesDescriptor = $convert.base64Decode('Cg1NZXRyaWNVcGRhdGVzEioKB3VwZGF0ZXMYASADKAsyEC52MS5NZXRyaWNVcGRhdGVSB3VwZGF0ZXM=');
@$core.Deprecated('Use settingDescriptor instead')
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

@$core.Deprecated('Use settingDescriptor instead')
const Setting_Destination$json = const {
  '1': 'Destination',
  '2': const [
    const {'1': 'NONE', '2': 0},
    const {'1': 'MOTOR', '2': 1},
    const {'1': 'MICROCONTROLLER', '2': 2},
  ],
};

/// Descriptor for `Setting`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List settingDescriptor = $convert.base64Decode('CgdTZXR0aW5nEjkKC2Rlc3RpbmF0aW9uGAEgASgOMhcudjEuU2V0dGluZy5EZXN0aW5hdGlvblILZGVzdGluYXRpb24SFAoFdmFsdWUYAiABKAFSBXZhbHVlEhAKA21heBgDIAEoAVIDbWF4EhAKA21pbhgEIAEoAVIDbWluEhIKBG5hbWUYBSABKAlSBG5hbWUSEgoEaW5mbxgGIAEoCVIEaW5mbxIiCgZ0YXJnZXQYByABKAsyCi52MS5UYXJnZXRSBnRhcmdldBIcCglzbWFsbE5hbWUYCCABKAlSCXNtYWxsTmFtZSI3CgtEZXN0aW5hdGlvbhIICgROT05FEAASCQoFTU9UT1IQARITCg9NSUNST0NPTlRST0xMRVIQAg==');
@$core.Deprecated('Use targetDescriptor instead')
const Target$json = const {
  '1': 'Target',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'uncertainty', '3': 2, '4': 1, '5': 1, '10': 'uncertainty'},
  ],
};

/// Descriptor for `Target`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List targetDescriptor = $convert.base64Decode('CgZUYXJnZXQSEgoEbmFtZRgBIAEoCVIEbmFtZRIgCgt1bmNlcnRhaW50eRgCIAEoAVILdW5jZXJ0YWludHk=');
@$core.Deprecated('Use settingUpdateDescriptor instead')
const SettingUpdate$json = const {
  '1': 'SettingUpdate',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
};

/// Descriptor for `SettingUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List settingUpdateDescriptor = $convert.base64Decode('Cg1TZXR0aW5nVXBkYXRlEhIKBG5hbWUYASABKAlSBG5hbWUSFAoFdmFsdWUYAiABKAFSBXZhbHVl');
@$core.Deprecated('Use targetUpdateDescriptor instead')
const TargetUpdate$json = const {
  '1': 'TargetUpdate',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
};

/// Descriptor for `TargetUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List targetUpdateDescriptor = $convert.base64Decode('CgxUYXJnZXRVcGRhdGUSEgoEbmFtZRgBIAEoCVIEbmFtZRIUCgV2YWx1ZRgCIAEoAVIFdmFsdWU=');
@$core.Deprecated('Use choiceDescriptor instead')
const Choice$json = const {
  '1': 'Choice',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'settings', '3': 2, '4': 3, '5': 11, '6': '.v1.Setting', '10': 'settings'},
  ],
};

/// Descriptor for `Choice`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List choiceDescriptor = $convert.base64Decode('CgZDaG9pY2USEgoEbmFtZRgBIAEoCVIEbmFtZRInCghzZXR0aW5ncxgCIAMoCzILLnYxLlNldHRpbmdSCHNldHRpbmdz');
@$core.Deprecated('Use selectorDescriptor instead')
const Selector$json = const {
  '1': 'Selector',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'selectedChoice', '3': 2, '4': 1, '5': 11, '6': '.v1.Choice', '10': 'selectedChoice'},
    const {'1': 'possibleChoices', '3': 3, '4': 3, '5': 11, '6': '.v1.Choice', '10': 'possibleChoices'},
  ],
};

/// Descriptor for `Selector`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List selectorDescriptor = $convert.base64Decode('CghTZWxlY3RvchISCgRuYW1lGAEgASgJUgRuYW1lEjIKDnNlbGVjdGVkQ2hvaWNlGAIgASgLMgoudjEuQ2hvaWNlUg5zZWxlY3RlZENob2ljZRI0Cg9wb3NzaWJsZUNob2ljZXMYAyADKAsyCi52MS5DaG9pY2VSD3Bvc3NpYmxlQ2hvaWNlcw==');
@$core.Deprecated('Use selectorsDescriptor instead')
const Selectors$json = const {
  '1': 'Selectors',
  '2': const [
    const {'1': 'selectors', '3': 1, '4': 3, '5': 11, '6': '.v1.Selector', '10': 'selectors'},
  ],
};

/// Descriptor for `Selectors`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List selectorsDescriptor = $convert.base64Decode('CglTZWxlY3RvcnMSKgoJc2VsZWN0b3JzGAEgAygLMgwudjEuU2VsZWN0b3JSCXNlbGVjdG9ycw==');
@$core.Deprecated('Use selectorUpdateDescriptor instead')
const SelectorUpdate$json = const {
  '1': 'SelectorUpdate',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'choiceName', '3': 2, '4': 1, '5': 9, '10': 'choiceName'},
  ],
};

/// Descriptor for `SelectorUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List selectorUpdateDescriptor = $convert.base64Decode('Cg5TZWxlY3RvclVwZGF0ZRISCgRuYW1lGAEgASgJUgRuYW1lEh4KCmNob2ljZU5hbWUYAiABKAlSCmNob2ljZU5hbWU=');
@$core.Deprecated('Use choiceUpdateDescriptor instead')
const ChoiceUpdate$json = const {
  '1': 'ChoiceUpdate',
  '2': const [
    const {'1': 'nameSelector', '3': 1, '4': 1, '5': 9, '10': 'nameSelector'},
    const {'1': 'newChoice', '3': 2, '4': 1, '5': 11, '6': '.v1.Choice', '10': 'newChoice'},
  ],
};

/// Descriptor for `ChoiceUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List choiceUpdateDescriptor = $convert.base64Decode('CgxDaG9pY2VVcGRhdGUSIgoMbmFtZVNlbGVjdG9yGAEgASgJUgxuYW1lU2VsZWN0b3ISKAoJbmV3Q2hvaWNlGAIgASgLMgoudjEuQ2hvaWNlUgluZXdDaG9pY2U=');
@$core.Deprecated('Use recipeDescriptor instead')
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

/// Descriptor for `Recipe`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recipeDescriptor = $convert.base64Decode('CgZSZWNpcGUSEgoEdXVpZBgBIAEoCVIEdXVpZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSEgoEaW5mbxgDIAEoCVIEaW5mbxInCghzZXR0aW5ncxgEIAMoCzILLnYxLlNldHRpbmdSCHNldHRpbmdzEioKCXNlbGVjdG9ycxgFIAMoCzIMLnYxLlNlbGVjdG9yUglzZWxlY3RvcnM=');
@$core.Deprecated('Use uUIDSDescriptor instead')
const UUIDS$json = const {
  '1': 'UUIDS',
  '2': const [
    const {'1': 'uuids', '3': 1, '4': 3, '5': 9, '10': 'uuids'},
  ],
};

/// Descriptor for `UUIDS`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uUIDSDescriptor = $convert.base64Decode('CgVVVUlEUxIUCgV1dWlkcxgBIAMoCVIFdXVpZHM=');
@$core.Deprecated('Use userDescriptor instead')
const User$json = const {
  '1': 'User',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'role', '3': 2, '4': 1, '5': 14, '6': '.v1.User.Roles', '10': 'role'},
  ],
  '4': const [User_Roles$json],
};

@$core.Deprecated('Use userDescriptor instead')
const User_Roles$json = const {
  '1': 'Roles',
  '2': const [
    const {'1': 'USER', '2': 0},
    const {'1': 'ADMIN', '2': 1},
    const {'1': 'CREATOR', '2': 2},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode('CgRVc2VyEhQKBXRpdGxlGAEgASgJUgV0aXRsZRIiCgRyb2xlGAIgASgOMg4udjEuVXNlci5Sb2xlc1IEcm9sZSIpCgVSb2xlcxIICgRVU0VSEAASCQoFQURNSU4QARILCgdDUkVBVE9SEAI=');
@$core.Deprecated('Use usersDescriptor instead')
const Users$json = const {
  '1': 'Users',
  '2': const [
    const {'1': 'users', '3': 1, '4': 3, '5': 11, '6': '.v1.User', '10': 'users'},
  ],
};

/// Descriptor for `Users`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List usersDescriptor = $convert.base64Decode('CgVVc2VycxIeCgV1c2VycxgBIAMoCzIILnYxLlVzZXJSBXVzZXJz');
@$core.Deprecated('Use wifiCredentialsDescriptor instead')
const WifiCredentials$json = const {
  '1': 'WifiCredentials',
  '2': const [
    const {'1': 'SSID', '3': 1, '4': 1, '5': 9, '10': 'SSID'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `WifiCredentials`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List wifiCredentialsDescriptor = $convert.base64Decode('Cg9XaWZpQ3JlZGVudGlhbHMSEgoEU1NJRBgBIAEoCVIEU1NJRBIaCghwYXNzd29yZBgCIAEoCVIIcGFzc3dvcmQ=');
@$core.Deprecated('Use wifiNamesDescriptor instead')
const WifiNames$json = const {
  '1': 'WifiNames',
  '2': const [
    const {'1': 'SSIDs', '3': 1, '4': 3, '5': 9, '10': 'SSIDs'},
  ],
};

/// Descriptor for `WifiNames`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List wifiNamesDescriptor = $convert.base64Decode('CglXaWZpTmFtZXMSFAoFU1NJRHMYASADKAlSBVNTSURz');
@$core.Deprecated('Use wifiStatusDescriptor instead')
const WifiStatus$json = const {
  '1': 'WifiStatus',
  '2': const [
    const {'1': 'isConnected', '3': 1, '4': 1, '5': 8, '10': 'isConnected'},
    const {'1': 'SSID', '3': 2, '4': 1, '5': 9, '10': 'SSID'},
  ],
};

/// Descriptor for `WifiStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List wifiStatusDescriptor = $convert.base64Decode('CgpXaWZpU3RhdHVzEiAKC2lzQ29ubmVjdGVkGAEgASgIUgtpc0Nvbm5lY3RlZBISCgRTU0lEGAIgASgJUgRTU0lE');
@$core.Deprecated('Use actionDescriptor instead')
const Action$json = const {
  '1': 'Action',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'payload', '3': 2, '4': 1, '5': 9, '10': 'payload'},
  ],
};

/// Descriptor for `Action`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List actionDescriptor = $convert.base64Decode('CgZBY3Rpb24SEgoEbmFtZRgBIAEoCVIEbmFtZRIYCgdwYXlsb2FkGAIgASgJUgdwYXlsb2Fk');
@$core.Deprecated('Use controlEventDescriptor instead')
const ControlEvent$json = const {
  '1': 'ControlEvent',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'payload', '3': 2, '4': 1, '5': 9, '10': 'payload'},
  ],
};

/// Descriptor for `ControlEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List controlEventDescriptor = $convert.base64Decode('CgxDb250cm9sRXZlbnQSEgoEbmFtZRgBIAEoCVIEbmFtZRIYCgdwYXlsb2FkGAIgASgJUgdwYXlsb2Fk');
@$core.Deprecated('Use sendResponseDescriptor instead')
const SendResponse$json = const {
  '1': 'SendResponse',
  '2': const [
    const {'1': 'error', '3': 1, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `SendResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendResponseDescriptor = $convert.base64Decode('CgxTZW5kUmVzcG9uc2USFAoFZXJyb3IYASABKAlSBWVycm9y');
@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = const {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor = $convert.base64Decode('CgVFbXB0eQ==');
@$core.Deprecated('Use doubleValueDescriptor instead')
const DoubleValue$json = const {
  '1': 'DoubleValue',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 1, '10': 'value'},
  ],
};

/// Descriptor for `DoubleValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List doubleValueDescriptor = $convert.base64Decode('CgtEb3VibGVWYWx1ZRIUCgV2YWx1ZRgBIAEoAVIFdmFsdWU=');
@$core.Deprecated('Use floatValueDescriptor instead')
const FloatValue$json = const {
  '1': 'FloatValue',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 2, '10': 'value'},
  ],
};

/// Descriptor for `FloatValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List floatValueDescriptor = $convert.base64Decode('CgpGbG9hdFZhbHVlEhQKBXZhbHVlGAEgASgCUgV2YWx1ZQ==');
@$core.Deprecated('Use int64ValueDescriptor instead')
const Int64Value$json = const {
  '1': 'Int64Value',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 3, '10': 'value'},
  ],
};

/// Descriptor for `Int64Value`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List int64ValueDescriptor = $convert.base64Decode('CgpJbnQ2NFZhbHVlEhQKBXZhbHVlGAEgASgDUgV2YWx1ZQ==');
@$core.Deprecated('Use uInt64ValueDescriptor instead')
const UInt64Value$json = const {
  '1': 'UInt64Value',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 4, '10': 'value'},
  ],
};

/// Descriptor for `UInt64Value`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uInt64ValueDescriptor = $convert.base64Decode('CgtVSW50NjRWYWx1ZRIUCgV2YWx1ZRgBIAEoBFIFdmFsdWU=');
@$core.Deprecated('Use int32ValueDescriptor instead')
const Int32Value$json = const {
  '1': 'Int32Value',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 5, '10': 'value'},
  ],
};

/// Descriptor for `Int32Value`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List int32ValueDescriptor = $convert.base64Decode('CgpJbnQzMlZhbHVlEhQKBXZhbHVlGAEgASgFUgV2YWx1ZQ==');
@$core.Deprecated('Use uInt32ValueDescriptor instead')
const UInt32Value$json = const {
  '1': 'UInt32Value',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 13, '10': 'value'},
  ],
};

/// Descriptor for `UInt32Value`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uInt32ValueDescriptor = $convert.base64Decode('CgtVSW50MzJWYWx1ZRIUCgV2YWx1ZRgBIAEoDVIFdmFsdWU=');
@$core.Deprecated('Use boolValueDescriptor instead')
const BoolValue$json = const {
  '1': 'BoolValue',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 8, '10': 'value'},
  ],
};

/// Descriptor for `BoolValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List boolValueDescriptor = $convert.base64Decode('CglCb29sVmFsdWUSFAoFdmFsdWUYASABKAhSBXZhbHVl');
@$core.Deprecated('Use stringValueDescriptor instead')
const StringValue$json = const {
  '1': 'StringValue',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 9, '10': 'value'},
  ],
};

/// Descriptor for `StringValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stringValueDescriptor = $convert.base64Decode('CgtTdHJpbmdWYWx1ZRIUCgV2YWx1ZRgBIAEoCVIFdmFsdWU=');
@$core.Deprecated('Use bytesValueDescriptor instead')
const BytesValue$json = const {
  '1': 'BytesValue',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `BytesValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bytesValueDescriptor = $convert.base64Decode('CgpCeXRlc1ZhbHVlEhQKBXZhbHVlGAEgASgMUgV2YWx1ZQ==');
