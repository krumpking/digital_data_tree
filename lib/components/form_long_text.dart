import 'package:flutter/material.dart';

import '../app/app_const.dart';

class FormLongText {
  static longText(
      {required String hintText, TextEditingController? textController}) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          controller: textController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 1, color: AppColors.fifthColor),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 1, color: AppColors.fifthColor),
              borderRadius: BorderRadius.circular(20),
            ),
            fillColor: AppColors.white,
            filled: true,
            contentPadding: const EdgeInsets.all(20),
            hintText: hintText,
          ),
          maxLines: 10,
        ));
  }
}
