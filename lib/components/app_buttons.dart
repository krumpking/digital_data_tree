import 'package:flutter/material.dart';

import '../app/app_const.dart';

class AppButton {
  static normalButton({
    required String title,
    VoidCallback? onPress,
    Color? backgroundColor = AppColors.primaryColor,
    Color? titleColor = Colors.white,
    bool shadow = true,
    double height = 50,
    double width = double.infinity,
  }) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(60),
          boxShadow: shadow
              ? const [
                  BoxShadow(color: AppColors.lightGray, blurRadius: 5),
                ]
              : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
