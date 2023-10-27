import 'package:flutter/cupertino.dart';

import '../../routes/app_routes.dart';

class NavigatorService {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> replace(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  Future<dynamic> navigateToDownloadQrPage({dynamic args}) {
    return navigatorKey.currentState!.pushReplacementNamed(
      AppRoutes.downloadQrPage,
      arguments: args,
    );
  }

  Future<dynamic> back() async {
    return navigatorKey.currentState!.pop();
  }
}
