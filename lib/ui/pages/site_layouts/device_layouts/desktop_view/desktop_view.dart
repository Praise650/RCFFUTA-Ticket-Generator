import 'package:flutter/material.dart';

import '../../../../layouts/scrollable_base_scaffold_body.dart';
import '../../../../widgets/layout/responsive_widget.dart';
import '../../../homepage/homepage.dart';

class DesktopView extends StatelessWidget {
  const DesktopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mobile = ResponsiveWidget.isMobile(context);
    final desktop = ResponsiveWidget.isDesktop(context);
    final tablet = ResponsiveWidget.isTablet(context);
    return const ScrollableBaseScaffoldBody(
      body: HomePageView(),
    );
  }
}

