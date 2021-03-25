import 'package:VennUI/api/configuration_service.dart';
import 'package:VennUI/api/metric_service.dart';
import 'package:VennUI/api/setting_service.dart';
import 'package:VennUI/providers/SettingsProvider.dart';
import 'package:VennUI/providers/WidgetGridProvider.dart';
import 'package:flutter/material.dart';
import 'package:VennUI/router.dart';
import 'package:provider/provider.dart';
import 'package:VennUI/providers/MetricProvider.dart';

void main() {
  // Launch GRPC client
  var c = ConfigurationService();
  var m = MetricService();
  // var a = AuthentificationService();
  // var n = NetworkServic();
  var r = SettingService();

  // Intl.defaultLocale = 'en_CA';
  RouterVenn.setupRouter();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<MetricProvider>(create: (_) => MetricProvider(m)),
    ChangeNotifierProvider<SettingsProvider>(
        create: (_) => SettingsProvider(r, m)),
    ChangeNotifierProvider<WidgetGridProvider>(
        create: (_) => WidgetGridProvider())
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
