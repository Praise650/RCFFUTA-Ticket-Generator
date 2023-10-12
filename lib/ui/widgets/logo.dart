import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.only(
        bottom: 40,
      ),
      width: 100,
      // height: 50,
      child: Image(
        image: AssetImage('assets/images/logo.png'),
        fit: BoxFit.contain,
        height: 100,
        width: 100,
      ),
    );
  }
}
