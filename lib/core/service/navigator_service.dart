import 'package:flutter/cupertino.dart';
import 'package:rcf_attendance_generator/routes/app_routes.dart';

class NavigatorService {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> navigateToDownloadQrPage(Object args) {
    return navigatorKey.currentState!.pushNamed(
      AppRoutes.downloadQrPage,
      arguments: args as String?,
    );
  }

  Future<dynamic> back(Object args) async {
    return navigatorKey.currentState!.pop();
  }
}
