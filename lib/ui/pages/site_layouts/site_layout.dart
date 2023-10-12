import 'package:flutter/material.dart';
import '../../layouts/base_scaffold.dart';
import '../../widgets/layout/responsive_widget.dart';
import 'device_layouts/desktop_view/desktop_view.dart';
import 'device_layouts/mobile_view/mobile_view.dart';
import 'device_layouts/tablet_view/tablet_view.dart';

class SiteLayout extends StatefulWidget {
  const SiteLayout({Key? key}) : super(key: key);

  @override
  State<SiteLayout> createState() => _SiteLayoutState();
}

class _SiteLayoutState extends State<SiteLayout> with SingleTickerProviderStateMixin{
  ScrollController scrollController = ScrollController();
  String message = '';

  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      setState(() {
        message = "reach the bottom";
      });
    }
    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      setState(() {
        message = "reach the top";
      });
    }
  }

  // _moveUp() {
  //   scrollController.animateTo(scrollController.offset - itemSize,
  //       curve: Curves.linear, duration: Duration(milliseconds: 500));
  // }

  // _moveDown() {
  //   scrollController.animateTo(scrollController.offset + itemSize,
  //       curve: Curves.linear, duration: Duration(milliseconds: 500));
  // }
  late TabController controller;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);

      controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  const ResponsiveWidget(
              mobile: MobileView(),
              tablet: TabletView(),
              desktop: DesktopView(),
    );
  }
}
