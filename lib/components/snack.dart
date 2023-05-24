import 'package:digital_data_tree/app/app_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Snack {
  static snack(String message) {
    return SnackBar(
      shape: const StadiumBorder(),
      backgroundColor: AppColors.primaryColor,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
      elevation: 30.0,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      content: Text(
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          message),
    );
  }

  static snackError(String message) {
    return SnackBar(
      shape: const StadiumBorder(),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
      elevation: 30.0,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      content: Text(
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          message),
    );
  }
}
