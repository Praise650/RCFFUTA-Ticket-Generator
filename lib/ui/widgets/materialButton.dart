import 'package:flutter/material.dart';

Widget materialButton(
    {String? text, IconData? iconData, VoidCallback? onPressed}) {
  return Material(
    elevation: 10.0,
    shadowColor: Colors.blue,
    color: Colors.blue[900],
    borderRadius: BorderRadius.circular(10),
    child: TextButton.icon(
      onPressed: onPressed,
      label: Text(
        '$text',
        style: TextStyle(color: Colors.white),
      ),
      icon: Icon(
        iconData,
        color: Colors.white,
      ),
    ),
  );
}
