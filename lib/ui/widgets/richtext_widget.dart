import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

Widget richText() {
  return Container(
    alignment: Alignment.center,
    child: RichText(
      text: TextSpan(
        text: "Didn't get the code? ",
        style: TextStyle(
          color: Colors.black,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = () {},
            text: 'Resend Code',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.blue,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    ),
  );
}
