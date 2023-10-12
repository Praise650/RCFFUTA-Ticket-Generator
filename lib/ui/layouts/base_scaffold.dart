import 'package:flutter/material.dart';

import '../styles/color.dart';
import '../widgets/layout/responsive_widget.dart';

class BaseScaffold extends StatelessWidget {
  final double elevation;
  final bool showBackBtn;
  final ScrollPhysics? physics;

  const BaseScaffold({
    Key? key,
    required this.body,
    this.backButtonAction,
    this.physics,
    // required this.titleText,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.showBackBtn = false,
    this.floatingActionButtonLocation,
    this.bottom,
    this.elevation = 0,
  }) : super(key: key);

  final Widget body;

  // final String titleText;
  final PreferredSizeWidget? bottom;
  final Function()? backButtonAction;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor ?? AppColors.scaffoldBgColor,
      // appBar: getAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: physics,
          child: body,
          // Padding(
          //   padding: Responsive.isMobile(context)
          //       ? const EdgeInsets.all(0)
          //       : EdgeInsets.symmetric(
          //           horizontal: MediaQuery.of(context).size.width -
          //               MediaQuery.of(context).size.width / 1.2,
          //         ),
          //   child: body,
          // ),
          // Container(
          //   alignment: Alignment.center,
          //   width: Responsive.isMobile(context)
          //       ? MediaQuery.of(context).size.width
          //       : MediaQuery.of(context).size.width * .5,
          //   // color: Colors.red,
          //   child: body,
          // ),
        ),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButtonLocation: floatingActionButtonLocation ??
          FloatingActionButtonLocation.centerDocked,
    );
  }
}
