import 'package:VennUI/api/authentification_service.dart';
import 'package:VennUI/api/configuration_service.dart';
import 'package:VennUI/api/metric_service.dart';
import 'package:VennUI/api/network_service.dart';
import 'package:VennUI/api/setting_service.dart';
import 'package:VennUI/providers/NetworkProvider.dart';
import 'package:VennUI/providers/SettingsProvider.dart';
import 'package:VennUI/providers/UserProvider.dart';
import 'package:VennUI/providers/WidgetGridProvider.dart';
import 'package:flutter/material.dart';
import 'package:VennUI/router.dart';
import 'package:provider/provider.dart';
import 'package:VennUI/providers/MetricProvider.dart';

void main() {
  // Launch GRPC client
  var c = ConfigurationService();
  var m = MetricService();
  var a = AuthentificationService();
  var n = NetworkService();
  var r = SettingService();

  // Intl.defaultLocale = 'en_CA';
  RouterVenn.setupRouter();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => MetricProvider(m)),
    ChangeNotifierProvider(create: (_) => SettingsProvider(r, m)),
    ChangeNotifierProvider(create: (_) => WidgetGridProvider()),
    ChangeNotifierProvider(create: (_) => NetworkProvider(n)),
    ChangeNotifierProvider(create: (_) => UserProvider(a)),
  ], child: MyApp()));
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
