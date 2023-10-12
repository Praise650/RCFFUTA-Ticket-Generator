import 'package:flutter/material.dart';

import '../../layouts/base_scaffold.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;
  final Widget tablet;

  const ResponsiveWidget({
    Key? key,
    required this.mobile,
    required this.desktop,
    required this.tablet,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 1100;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 650;

  static double kSizeHeight(BuildContext context) =>
      MediaQuery.of(context).size.height / 528; //My design size is 528,

  static double kSizeWidth(BuildContext context) =>
      MediaQuery.of(context).size.height / 500; //My design size is 500,

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 1100)
            return desktop;
          else if (constraints.maxWidth >= 650)
            return tablet;
          else
            return mobile;
        },
      ),
    );
  }
}
