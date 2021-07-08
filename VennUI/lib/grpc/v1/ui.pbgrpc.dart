///
//  Generated code. Do not modify.
//  source: ui.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'ui.pb.dart' as $0;
export 'ui.pb.dart';

class MetricServiceClient extends $grpc.Client {
  static final _$getAll = $grpc.ClientMethod<$0.Empty, $0.MetricUpdates>(
      '/v1.MetricService/GetAll',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.MetricUpdates.fromBuffer(value));
  static final _$subscribe = $grpc.ClientMethod<$0.Empty, $0.MetricUpdates>(
      '/v1.MetricService/Subscribe',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.MetricUpdates.fromBuffer(value));
  static final _$readConfig = $grpc.ClientMethod<$0.Empty, $0.MetricConfigs>(
      '/v1.MetricService/ReadConfig',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.MetricConfigs.fromBuffer(value));
  static final _$updateConfig = $grpc.ClientMethod<$0.MetricConfigs, $0.Empty>(
      '/v1.MetricService/UpdateConfig',
      ($0.MetricConfigs value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));

  MetricServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.MetricUpdates> getAll($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAll, request, options: options);
  }

  $grpc.ResponseStream<$0.MetricUpdates> subscribe($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$subscribe, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.MetricConfigs> readConfig($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$readConfig, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> updateConfig($0.MetricConfigs request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateConfig, request, options: options);
  }
}

abstract class MetricServiceBase extends $grpc.Service {
  $core.String get $name => 'v1.MetricService';

  MetricServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.MetricUpdates>(
        'GetAll',
        getAll_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.MetricUpdates value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.MetricUpdates>(
        'Subscribe',
        subscribe_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.MetricUpdates value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.MetricConfigs>(
        'ReadConfig',
        readConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.MetricConfigs value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MetricConfigs, $0.Empty>(
        'UpdateConfig',
        updateConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.MetricConfigs.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$0.MetricUpdates> getAll_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getAll(call, await request);
  }

  $async.Stream<$0.MetricUpdates> subscribe_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async* {
    yield* subscribe(call, await request);
  }

  $async.Future<$0.MetricConfigs> readConfig_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return readConfig(call, await request);
  }

  $async.Future<$0.Empty> updateConfig_Pre(
      $grpc.ServiceCall call, $async.Future<$0.MetricConfigs> request) async {
    return updateConfig(call, await request);
  }

  $async.Future<$0.MetricUpdates> getAll(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Stream<$0.MetricUpdates> subscribe(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.MetricConfigs> readConfig(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.Empty> updateConfig(
      $grpc.ServiceCall call, $0.MetricConfigs request);
}

class SettingServiceClient extends $grpc.Client {
  static final _$createRecipe = $grpc.ClientMethod<$0.Empty, $0.Recipe>(
      '/v1.SettingService/CreateRecipe',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Recipe.fromBuffer(value));
  static final _$readRecipesUUID = $grpc.ClientMethod<$0.Empty, $0.UUIDS>(
      '/v1.SettingService/ReadRecipesUUID',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UUIDS.fromBuffer(value));
  static final _$readRecipe = $grpc.ClientMethod<$0.StringValue, $0.Recipe>(
      '/v1.SettingService/ReadRecipe',
      ($0.StringValue value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Recipe.fromBuffer(value));
  static final _$readCurrentRecipe = $grpc.ClientMethod<$0.Empty, $0.Recipe>(
      '/v1.SettingService/ReadCurrentRecipe',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Recipe.fromBuffer(value));
  static final _$readSelectorList = $grpc.ClientMethod<$0.Empty, $0.Selectors>(
      '/v1.SettingService/ReadSelectorList',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Selectors.fromBuffer(value));
  static final _$updateSetting = $grpc.ClientMethod<$0.SettingUpdate, $0.Empty>(
      '/v1.SettingService/UpdateSetting',
      ($0.SettingUpdate value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$updateUncertainty =
      $grpc.ClientMethod<$0.TargetUpdate, $0.Empty>(
          '/v1.SettingService/UpdateUncertainty',
          ($0.TargetUpdate value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$updateSelectedChoice =
      $grpc.ClientMethod<$0.SelectorUpdate, $0.Empty>(
          '/v1.SettingService/UpdateSelectedChoice',
          ($0.SelectorUpdate value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$updateChoice = $grpc.ClientMethod<$0.ChoiceUpdate, $0.Empty>(
      '/v1.SettingService/UpdateChoice',
      ($0.ChoiceUpdate value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$updateCurrentRecipe =
      $grpc.ClientMethod<$0.StringValue, $0.Empty>(
          '/v1.SettingService/UpdateCurrentRecipe',
          ($0.StringValue value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$updateRecipe = $grpc.ClientMethod<$0.Recipe, $0.Empty>(
      '/v1.SettingService/UpdateRecipe',
      ($0.Recipe value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$deleteRecipe = $grpc.ClientMethod<$0.StringValue, $0.Empty>(
      '/v1.SettingService/DeleteRecipe',
      ($0.StringValue value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));

  SettingServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Recipe> createRecipe($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRecipe, request, options: options);
  }

  $grpc.ResponseFuture<$0.UUIDS> readRecipesUUID($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$readRecipesUUID, request, options: options);
  }

  $grpc.ResponseFuture<$0.Recipe> readRecipe($0.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$readRecipe, request, options: options);
  }

  $grpc.ResponseFuture<$0.Recipe> readCurrentRecipe($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$readCurrentRecipe, request, options: options);
  }

  $grpc.ResponseFuture<$0.Selectors> readSelectorList($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$readSelectorList, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> updateSetting($0.SettingUpdate request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSetting, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> updateUncertainty($0.TargetUpdate request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateUncertainty, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> updateSelectedChoice($0.SelectorUpdate request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSelectedChoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> updateChoice($0.ChoiceUpdate request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateChoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> updateCurrentRecipe($0.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCurrentRecipe, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> updateRecipe($0.Recipe request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateRecipe, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> deleteRecipe($0.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteRecipe, request, options: options);
  }
}

abstract class SettingServiceBase extends $grpc.Service {
  $core.String get $name => 'v1.SettingService';

  SettingServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.Recipe>(
        'CreateRecipe',
        createRecipe_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.Recipe value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.UUIDS>(
        'ReadRecipesUUID',
        readRecipesUUID_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.UUIDS value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StringValue, $0.Recipe>(
        'ReadRecipe',
        readRecipe_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value),
        ($0.Recipe value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.Recipe>(
        'ReadCurrentRecipe',
        readCurrentRecipe_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.Recipe value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.Selectors>(
        'ReadSelectorList',
        readSelectorList_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.Selectors value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SettingUpdate, $0.Empty>(
        'UpdateSetting',
        updateSetting_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SettingUpdate.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TargetUpdate, $0.Empty>(
        'UpdateUncertainty',
        updateUncertainty_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TargetUpdate.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SelectorUpdate, $0.Empty>(
        'UpdateSelectedChoice',
        updateSelectedChoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SelectorUpdate.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChoiceUpdate, $0.Empty>(
        'UpdateChoice',
        updateChoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ChoiceUpdate.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StringValue, $0.Empty>(
        'UpdateCurrentRecipe',
        updateCurrentRecipe_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Recipe, $0.Empty>(
        'UpdateRecipe',
        updateRecipe_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Recipe.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StringValue, $0.Empty>(
        'DeleteRecipe',
        deleteRecipe_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$0.Recipe> createRecipe_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return createRecipe(call, await request);
  }

  $async.Future<$0.UUIDS> readRecipesUUID_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return readRecipesUUID(call, await request);
  }

  $async.Future<$0.Recipe> readRecipe_Pre(
      $grpc.ServiceCall call, $async.Future<$0.StringValue> request) async {
    return readRecipe(call, await request);
  }

  $async.Future<$0.Recipe> readCurrentRecipe_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return readCurrentRecipe(call, await request);
  }

  $async.Future<$0.Selectors> readSelectorList_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return readSelectorList(call, await request);
  }

  $async.Future<$0.Empty> updateSetting_Pre(
      $grpc.ServiceCall call, $async.Future<$0.SettingUpdate> request) async {
    return updateSetting(call, await request);
  }

  $async.Future<$0.Empty> updateUncertainty_Pre(
      $grpc.ServiceCall call, $async.Future<$0.TargetUpdate> request) async {
    return updateUncertainty(call, await request);
  }

  $async.Future<$0.Empty> updateSelectedChoice_Pre(
      $grpc.ServiceCall call, $async.Future<$0.SelectorUpdate> request) async {
    return updateSelectedChoice(call, await request);
  }

  $async.Future<$0.Empty> updateChoice_Pre(
      $grpc.ServiceCall call, $async.Future<$0.ChoiceUpdate> request) async {
    return updateChoice(call, await request);
  }

  $async.Future<$0.Empty> updateCurrentRecipe_Pre(
      $grpc.ServiceCall call, $async.Future<$0.StringValue> request) async {
    return updateCurrentRecipe(call, await request);
  }

  $async.Future<$0.Empty> updateRecipe_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Recipe> request) async {
    return updateRecipe(call, await request);
  }

  $async.Future<$0.Empty> deleteRecipe_Pre(
      $grpc.ServiceCall call, $async.Future<$0.StringValue> request) async {
    return deleteRecipe(call, await request);
  }

  $async.Future<$0.Recipe> createRecipe(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.UUIDS> readRecipesUUID(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.Recipe> readRecipe(
      $grpc.ServiceCall call, $0.StringValue request);
  $async.Future<$0.Recipe> readCurrentRecipe(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.Selectors> readSelectorList(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.Empty> updateSetting(
      $grpc.ServiceCall call, $0.SettingUpdate request);
  $async.Future<$0.Empty> updateUncertainty(
      $grpc.ServiceCall call, $0.TargetUpdate request);
  $async.Future<$0.Empty> updateSelectedChoice(
      $grpc.ServiceCall call, $0.SelectorUpdate request);
  $async.Future<$0.Empty> updateChoice(
      $grpc.ServiceCall call, $0.ChoiceUpdate request);
  $async.Future<$0.Empty> updateCurrentRecipe(
      $grpc.ServiceCall call, $0.StringValue request);
  $async.Future<$0.Empty> updateRecipe(
      $grpc.ServiceCall call, $0.Recipe request);
  $async.Future<$0.Empty> deleteRecipe(
      $grpc.ServiceCall call, $0.StringValue request);
}

class AuthentificationServiceClient extends $grpc.Client {
  static final _$readUserList = $grpc.ClientMethod<$0.Empty, $0.Users>(
      '/v1.AuthentificationService/ReadUserList',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Users.fromBuffer(value));
  static final _$updateCurrentUser = $grpc.ClientMethod<$0.User, $0.Empty>(
      '/v1.AuthentificationService/UpdateCurrentUser',
      ($0.User value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$getCurrentUser = $grpc.ClientMethod<$0.Empty, $0.User>(
      '/v1.AuthentificationService/GetCurrentUser',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.User.fromBuffer(value));

  AuthentificationServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Users> readUserList($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$readUserList, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> updateCurrentUser($0.User request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCurrentUser, request, options: options);
  }

  $grpc.ResponseFuture<$0.User> getCurrentUser($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCurrentUser, request, options: options);
  }
}

abstract class AuthentificationServiceBase extends $grpc.Service {
  $core.String get $name => 'v1.AuthentificationService';

  AuthentificationServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.Users>(
        'ReadUserList',
        readUserList_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.Users value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.User, $0.Empty>(
        'UpdateCurrentUser',
        updateCurrentUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.User.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.User>(
        'GetCurrentUser',
        getCurrentUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.User value) => value.writeToBuffer()));
  }

  $async.Future<$0.Users> readUserList_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return readUserList(call, await request);
  }

  $async.Future<$0.Empty> updateCurrentUser_Pre(
      $grpc.ServiceCall call, $async.Future<$0.User> request) async {
    return updateCurrentUser(call, await request);
  }

  $async.Future<$0.User> getCurrentUser_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getCurrentUser(call, await request);
  }

  $async.Future<$0.Users> readUserList(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.Empty> updateCurrentUser(
      $grpc.ServiceCall call, $0.User request);
  $async.Future<$0.User> getCurrentUser(
      $grpc.ServiceCall call, $0.Empty request);
}

class NetworkServiceClient extends $grpc.Client {
  static final _$readStatus = $grpc.ClientMethod<$0.Empty, $0.WifiStatus>(
      '/v1.NetworkService/ReadStatus',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.WifiStatus.fromBuffer(value));
  static final _$readWifiList = $grpc.ClientMethod<$0.Empty, $0.WifiNames>(
      '/v1.NetworkService/ReadWifiList',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.WifiNames.fromBuffer(value));
  static final _$connectWifi = $grpc.ClientMethod<$0.WifiCredentials, $0.Empty>(
      '/v1.NetworkService/ConnectWifi',
      ($0.WifiCredentials value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));

  NetworkServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.WifiStatus> readStatus($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$readStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.WifiNames> readWifiList($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$readWifiList, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> connectWifi($0.WifiCredentials request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$connectWifi, request, options: options);
  }
}

abstract class NetworkServiceBase extends $grpc.Service {
  $core.String get $name => 'v1.NetworkService';

  NetworkServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.WifiStatus>(
        'ReadStatus',
        readStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.WifiStatus value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.WifiNames>(
        'ReadWifiList',
        readWifiList_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.WifiNames value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WifiCredentials, $0.Empty>(
        'ConnectWifi',
        connectWifi_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.WifiCredentials.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$0.WifiStatus> readStatus_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return readStatus(call, await request);
  }

  $async.Future<$0.WifiNames> readWifiList_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return readWifiList(call, await request);
  }

  $async.Future<$0.Empty> connectWifi_Pre(
      $grpc.ServiceCall call, $async.Future<$0.WifiCredentials> request) async {
    return connectWifi(call, await request);
  }

  $async.Future<$0.WifiStatus> readStatus(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.WifiNames> readWifiList(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.Empty> connectWifi(
      $grpc.ServiceCall call, $0.WifiCredentials request);
}

class ConfigurationServiceClient extends $grpc.Client {
  ConfigurationServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);
}

abstract class ConfigurationServiceBase extends $grpc.Service {
  $core.String get $name => 'v1.ConfigurationService';

  ConfigurationServiceBase() {}
}

class ControlServiceClient extends $grpc.Client {
  static final _$send = $grpc.ClientMethod<$0.Action, $0.SendResponse>(
      '/v1.ControlService/Send',
      ($0.Action value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SendResponse.fromBuffer(value));
  static final _$subscribe = $grpc.ClientMethod<$0.Empty, $0.ControlEvent>(
      '/v1.ControlService/Subscribe',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ControlEvent.fromBuffer(value));

  ControlServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.SendResponse> send($0.Action request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$send, request, options: options);
  }

  $grpc.ResponseStream<$0.ControlEvent> subscribe($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$subscribe, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class ControlServiceBase extends $grpc.Service {
  $core.String get $name => 'v1.ControlService';

  ControlServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Action, $0.SendResponse>(
        'Send',
        send_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Action.fromBuffer(value),
        ($0.SendResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.ControlEvent>(
        'Subscribe',
        subscribe_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.ControlEvent value) => value.writeToBuffer()));
  }

  $async.Future<$0.SendResponse> send_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Action> request) async {
    return send(call, await request);
  }

  $async.Stream<$0.ControlEvent> subscribe_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async* {
    yield* subscribe(call, await request);
  }

  $async.Future<$0.SendResponse> send(
      $grpc.ServiceCall call, $0.Action request);
  $async.Stream<$0.ControlEvent> subscribe(
      $grpc.ServiceCall call, $0.Empty request);
}

class MotorControlServiceClient extends $grpc.Client {
  static final _$home = $grpc.ClientMethod<$0.Empty, $0.Empty>(
      '/v1.MotorControlService/Home',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$startCycle = $grpc.ClientMethod<$0.Empty, $0.Empty>(
      '/v1.MotorControlService/StartCycle',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$stopCycle = $grpc.ClientMethod<$0.Empty, $0.Empty>(
      '/v1.MotorControlService/StopCycle',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));

  MotorControlServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Empty> home($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$home, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> startCycle($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$startCycle, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> stopCycle($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$stopCycle, request, options: options);
  }
}

abstract class MotorControlServiceBase extends $grpc.Service {
  $core.String get $name => 'v1.MotorControlService';

  MotorControlServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.Empty>(
        'Home',
        home_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.Empty>(
        'StartCycle',
        startCycle_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.Empty>(
        'StopCycle',
        stopCycle_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$0.Empty> home_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return home(call, await request);
  }

  $async.Future<$0.Empty> startCycle_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return startCycle(call, await request);
  }

  $async.Future<$0.Empty> stopCycle_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return stopCycle(call, await request);
  }

  $async.Future<$0.Empty> home($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.Empty> startCycle($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.Empty> stopCycle($grpc.ServiceCall call, $0.Empty request);
}
