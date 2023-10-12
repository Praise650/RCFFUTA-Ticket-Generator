import 'package:flutter/material.dart';

import '../../utils/platform_size_checker.dart';


class ScrollableBaseScaffoldBody extends StatelessWidget {
  const ScrollableBaseScaffoldBody({
    Key? key,
    // required this.padding,
    required this.body,
  }) : super(key: key);

  // final double padding;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    var widthSize = MediaQuery.of(context).size.width;
    var padding = widthSize * .2;
    return SingleChildScrollView(
      child: Container(
          // color: Colors.orange,
          // width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: SizeChecker.isMobile(context) ? 5 : padding,
            vertical: 20,
          ),
          child: body),
    );
  }
}
