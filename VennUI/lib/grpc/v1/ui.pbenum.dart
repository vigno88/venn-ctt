///
//  Generated code. Do not modify.
//  source: ui.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Setting_Destination extends $pb.ProtobufEnum {
  static const Setting_Destination NONE = Setting_Destination._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NONE');
  static const Setting_Destination MOTOR = Setting_Destination._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOTOR');
  static const Setting_Destination MICROCONTROLLER = Setting_Destination._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MICROCONTROLLER');

  static const $core.List<Setting_Destination> values = <Setting_Destination> [
    NONE,
    MOTOR,
    MICROCONTROLLER,
  ];

  static final $core.Map<$core.int, Setting_Destination> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Setting_Destination valueOf($core.int value) => _byValue[value];

  const Setting_Destination._($core.int v, $core.String n) : super(v, n);
}

class User_Roles extends $pb.ProtobufEnum {
  static const User_Roles USER = User_Roles._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'USER');
  static const User_Roles ADMIN = User_Roles._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ADMIN');
  static const User_Roles CREATOR = User_Roles._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CREATOR');

  static const $core.List<User_Roles> values = <User_Roles> [
    USER,
    ADMIN,
    CREATOR,
  ];

  static final $core.Map<$core.int, User_Roles> _byValue = $pb.ProtobufEnum.initByValue(values);
  static User_Roles valueOf($core.int value) => _byValue[value];

  const User_Roles._($core.int v, $core.String n) : super(v, n);
}

