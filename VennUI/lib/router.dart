import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:VennUI/pages/pages.dart';

class RouterVenn {
  static FluroRouter router = FluroRouter();
  static DashboardPage d = DashboardPage();
  static SettingsPage s = SettingsPage();
  // Create our route handlers
  static Handler _aboutHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          AboutPage());
  static Handler _dashboardHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) => d);
  static Handler _settingsHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) => s);

  // Setup the handlers for our routes
  static void setupRouter() {
    router.define(
      'about',
      handler: _aboutHandler,
    );
    router.define(
      'dashboard',
      handler: _dashboardHandler,
    );
    router.define(
      'settings',
      handler: _settingsHandler,
    );
  }
}
