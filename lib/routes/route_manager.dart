import 'package:flutter/material.dart';

import 'app_routes.dart';
import 'routes.dart';

class RouteManager {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) => Container(),
          settings: settings,
        );
      case AppRoutes.generateQrPage:
        return MaterialPageRoute(
          builder: (context) => const GenerateQRPage(),
          settings: settings,
        );
      case AppRoutes.logInPage:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
          settings: settings,
        );
      case AppRoutes.listUserPage:
        return MaterialPageRoute(
          builder: (context) => const ListUsersPage(),
          settings: settings,
        );
      case AppRoutes.downloadQrPage:
        var userName = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => DownloadQRPage(userId: userName),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const GenerateQRPage(),
          settings: settings,
        );
    }
  }
}
