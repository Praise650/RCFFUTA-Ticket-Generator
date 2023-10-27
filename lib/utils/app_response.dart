import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppResponse {

  static success(String message) {
    Get.snackbar(
      "Success",
      message,
      backgroundColor: Colors.green.withOpacity(.4),
    );
  }

  static error(String message) {
    Get.snackbar(
      "Error",
      message,
      backgroundColor: Colors.red.withOpacity(.4),
    );
  }
}
