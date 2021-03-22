///
//  Generated code. Do not modify.
//  source: ui.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'ui.pb.dart' as $0;
export 'ui.pb.dart';

class MetricServiceClient extends $grpc.Client {
  static final _$get = $grpc.ClientMethod<$0.Empty, $0.Metrics>(
      '/v1.MetricService/Get',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Metrics.fromBuffer(value));
  static final _$subscribe = $grpc.ClientMethod<$0.Empty, $0.Metrics>(
      '/v1.MetricService/Subscribe',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Metrics.fromBuffer(value));

  MetricServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Metrics> get($0.Empty request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$get, request, options: options);
  }

  $grpc.ResponseStream<$0.Metrics> subscribe($0.Empty request,
      {$grpc.CallOptions options}) {
    return $createStreamingCall(
        _$subscribe, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class MetricServiceBase extends $grpc.Service {
  $core.String get $name => 'v1.MetricService';

  MetricServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.Metrics>(
        'Get',
        get_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.Metrics value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.Metrics>(
        'Subscribe',
        subscribe_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.Metrics value) => value.writeToBuffer()));
  }

  $async.Future<$0.Metrics> get_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return get(call, await request);
  }

  $async.Stream<$0.Metrics> subscribe_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async* {
    yield* subscribe(call, await request);
  }

  $async.Future<$0.Metrics> get($grpc.ServiceCall call, $0.Empty request);
  $async.Stream<$0.Metrics> subscribe($grpc.ServiceCall call, $0.Empty request);
}

class SettingServiceClient extends $grpc.Client {
  static final _$setSetting = $grpc.ClientMethod<$0.Setting, $0.Empty>(
      '/v1.SettingService/SetSetting',
      ($0.Setting value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$getRecipesUUID = $grpc.ClientMethod<$0.Empty, $0.UUIDS>(
      '/v1.SettingService/GetRecipesUUID',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UUIDS.fromBuffer(value));
  static final _$getRecipe = $grpc.ClientMethod<$0.StringValue, $0.Recipe>(
      '/v1.SettingService/GetRecipe',
      ($0.StringValue value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Recipe.fromBuffer(value));
  static final _$createRecipe = $grpc.ClientMethod<$0.Empty, $0.Recipe>(
      '/v1.SettingService/CreateRecipe',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Recipe.fromBuffer(value));
  static final _$selectRecipe = $grpc.ClientMethod<$0.StringValue, $0.Empty>(
      '/v1.SettingService/SelectRecipe',
      ($0.StringValue value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));

  SettingServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Empty> setSetting($0.Setting request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$setSetting, request, options: options);
  }

  $grpc.ResponseFuture<$0.UUIDS> getRecipesUUID($0.Empty request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getRecipesUUID, request, options: options);
  }

  $grpc.ResponseFuture<$0.Recipe> getRecipe($0.StringValue request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getRecipe, request, options: options);
  }

  $grpc.ResponseFuture<$0.Recipe> createRecipe($0.Empty request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$createRecipe, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> selectRecipe($0.StringValue request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$selectRecipe, request, options: options);
  }
}

abstract class SettingServiceBase extends $grpc.Service {
  $core.String get $name => 'v1.SettingService';

  SettingServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Setting, $0.Empty>(
        'SetSetting',
        setSetting_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Setting.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.UUIDS>(
        'GetRecipesUUID',
        getRecipesUUID_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.UUIDS value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StringValue, $0.Recipe>(
        'GetRecipe',
        getRecipe_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value),
        ($0.Recipe value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.Recipe>(
        'CreateRecipe',
        createRecipe_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.Recipe value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StringValue, $0.Empty>(
        'SelectRecipe',
        selectRecipe_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$0.Empty> setSetting_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Setting> request) async {
    return setSetting(call, await request);
  }

  $async.Future<$0.UUIDS> getRecipesUUID_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getRecipesUUID(call, await request);
  }

  $async.Future<$0.Recipe> getRecipe_Pre(
      $grpc.ServiceCall call, $async.Future<$0.StringValue> request) async {
    return getRecipe(call, await request);
  }

  $async.Future<$0.Recipe> createRecipe_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return createRecipe(call, await request);
  }

  $async.Future<$0.Empty> selectRecipe_Pre(
      $grpc.ServiceCall call, $async.Future<$0.StringValue> request) async {
    return selectRecipe(call, await request);
  }

  $async.Future<$0.Empty> setSetting(
      $grpc.ServiceCall call, $0.Setting request);
  $async.Future<$0.UUIDS> getRecipesUUID(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.Recipe> getRecipe(
      $grpc.ServiceCall call, $0.StringValue request);
  $async.Future<$0.Recipe> createRecipe(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.Empty> selectRecipe(
      $grpc.ServiceCall call, $0.StringValue request);
}

class AuthentificationServiceClient extends $grpc.Client {
  static final _$authentificate = $grpc.ClientMethod<$0.Credentials, $0.Empty>(
      '/v1.AuthentificationService/Authentificate',
      ($0.Credentials value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));

  AuthentificationServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Empty> authentificate($0.Credentials request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$authentificate, request, options: options);
  }
}

abstract class AuthentificationServiceBase extends $grpc.Service {
  $core.String get $name => 'v1.AuthentificationService';

  AuthentificationServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Credentials, $0.Empty>(
        'Authentificate',
        authentificate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Credentials.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$0.Empty> authentificate_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Credentials> request) async {
    return authentificate(call, await request);
  }

  $async.Future<$0.Empty> authentificate(
      $grpc.ServiceCall call, $0.Credentials request);
}

class NetworkServiceClient extends $grpc.Client {
  static final _$connectWifi = $grpc.ClientMethod<$0.WifiCredentials, $0.Empty>(
      '/v1.NetworkService/ConnectWifi',
      ($0.WifiCredentials value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));

  NetworkServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Empty> connectWifi($0.WifiCredentials request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$connectWifi, request, options: options);
  }
}

abstract class NetworkServiceBase extends $grpc.Service {
  $core.String get $name => 'v1.NetworkService';

  NetworkServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.WifiCredentials, $0.Empty>(
        'ConnectWifi',
        connectWifi_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.WifiCredentials.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$0.Empty> connectWifi_Pre(
      $grpc.ServiceCall call, $async.Future<$0.WifiCredentials> request) async {
    return connectWifi(call, await request);
  }

  $async.Future<$0.Empty> connectWifi(
      $grpc.ServiceCall call, $0.WifiCredentials request);
}

class ConfigurationServiceClient extends $grpc.Client {
  static final _$getConfig = $grpc.ClientMethod<$0.Empty, $0.Configuration>(
      '/v1.ConfigurationService/GetConfig',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Configuration.fromBuffer(value));
  static final _$setConfig = $grpc.ClientMethod<$0.Configuration, $0.Empty>(
      '/v1.ConfigurationService/SetConfig',
      ($0.Configuration value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));

  ConfigurationServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Configuration> getConfig($0.Empty request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getConfig, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> setConfig($0.Configuration request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$setConfig, request, options: options);
  }
}

abstract class ConfigurationServiceBase extends $grpc.Service {
  $core.String get $name => 'v1.ConfigurationService';

  ConfigurationServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.Configuration>(
        'GetConfig',
        getConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.Configuration value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Configuration, $0.Empty>(
        'SetConfig',
        setConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Configuration.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$0.Configuration> getConfig_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getConfig(call, await request);
  }

  $async.Future<$0.Empty> setConfig_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Configuration> request) async {
    return setConfig(call, await request);
  }

  $async.Future<$0.Configuration> getConfig(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.Empty> setConfig(
      $grpc.ServiceCall call, $0.Configuration request);
}

class ControlServiceClient extends $grpc.Client {
  static final _$send = $grpc.ClientMethod<$0.Action, $0.Empty>(
      '/v1.ControlService/Send',
      ($0.Action value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$subscribe = $grpc.ClientMethod<$0.Empty, $0.ControlEvent>(
      '/v1.ControlService/Subscribe',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ControlEvent.fromBuffer(value));

  ControlServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Empty> send($0.Action request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$send, request, options: options);
  }

  $grpc.ResponseStream<$0.ControlEvent> subscribe($0.Empty request,
      {$grpc.CallOptions options}) {
    return $createStreamingCall(
        _$subscribe, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class ControlServiceBase extends $grpc.Service {
  $core.String get $name => 'v1.ControlService';

  ControlServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Action, $0.Empty>(
        'Send',
        send_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Action.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.ControlEvent>(
        'Subscribe',
        subscribe_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.ControlEvent value) => value.writeToBuffer()));
  }

  $async.Future<$0.Empty> send_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Action> request) async {
    return send(call, await request);
  }

  $async.Stream<$0.ControlEvent> subscribe_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async* {
    yield* subscribe(call, await request);
  }

  $async.Future<$0.Empty> send($grpc.ServiceCall call, $0.Action request);
  $async.Stream<$0.ControlEvent> subscribe(
      $grpc.ServiceCall call, $0.Empty request);
}
