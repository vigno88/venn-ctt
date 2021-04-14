import 'dart:async';

import 'package:VennUI/grpc/authentification.dart';
import 'package:VennUI/grpc/control.dart';
import 'package:VennUI/grpc/metric.dart';
import 'package:VennUI/grpc/network.dart';
import 'package:VennUI/grpc/settings.dart';
import 'package:VennUI/providers/NetworkProvider.dart';
import 'package:VennUI/providers/SettingsProvider.dart';
import 'package:VennUI/providers/UserProvider.dart';
import 'package:VennUI/providers/DashboardProvider.dart';
import 'package:VennUI/providers/dashboard_services/Control.dart';
import 'package:VennUI/providers/dashboard_services/Metrics.dart';
import 'package:flutter/material.dart';
import 'package:VennUI/router.dart';
import 'package:provider/provider.dart';

void main() {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (FlutterErrorDetails errorDetails) {
      print('This is an error on the Flutter SDK');
      print(errorDetails.exception);
      print('-----');
      print(errorDetails.stack);
    };

    // Launch GRPC clients
    // var cAPI = ConfigurationGrpcAPI();
    var mAPI = MetricGrpcAPI();
    var aAPI = AuthentificationGrpcAPI();
    var nAPI = NetworkGrpcAPI();
    var rAPI = SettingGrpcAPI();
    var ctlAPI = ControlGrpcAPI();

    // Launch dashboard services
    var mService = MetricService(mAPI);
    var cService = ControlService(ctlAPI);

    // Intl.defaultLocale = 'en_CA';
    RouterVenn.setupRouter();
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => SettingsProvider(rAPI, mAPI)),
      ChangeNotifierProvider(
          create: (_) => DashboardProvider(mService, cService)),
      ChangeNotifierProvider(create: (_) => NetworkProvider(nAPI)),
      ChangeNotifierProvider(create: (_) => UserProvider(aAPI)),
    ], child: MyApp()));
  }, (error, stackTrace) {
    print('This is a pure Dart error');
    print(error);
    print('-----');
    print(stackTrace);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VennUI',
      theme: ThemeData(fontFamily: 'Helvetica'),
      // Initial Page when booting the app
      initialRoute: 'dashboard',
      onGenerateRoute: RouterVenn.router.generator,
    );
  }
}
