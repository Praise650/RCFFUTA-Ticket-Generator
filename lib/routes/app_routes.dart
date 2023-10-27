import 'package:flutter/material.dart';

import '../routes/routes.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';
  static const String generateQrPage = '/generate_qr_page';
  static const String logInPage = '/log_in_screen';
  static const String listUserPage = '/list_user_page';
  static const String downloadQrPage = '/download_qr_page';
  static const String homeScreen = '/home_screen';
  static const String dashboard = '/dashboard-screen';
  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => Container(),
    generateQrPage: (context) => const GenerateQRPage(),
    logInPage: (context) => const LoginPage(),
    listUserPage: (context) => const ListUsersPage(),
    // downloadQrPage: (context) => const DownloadQRPage(userId: '',),
    // appNavigationScreen: (context) => AppNavigationScreen()
  };
}
