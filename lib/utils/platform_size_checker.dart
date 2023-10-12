import '../ui/widgets/layout/responsive_widget.dart';

class SizeChecker{
  static isMobile(context) => ResponsiveWidget.isMobile(context);
  static isDesktop(context) => ResponsiveWidget.isDesktop(context);
  static isTablet(context) => ResponsiveWidget.isTablet(context);
}