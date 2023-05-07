import 'package:flutter/material.dart';

import '../app/app_const.dart';

class FormNumberText {
  static numberText(
      {required String hintText, TextEditingController? textController}) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          controller: textController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 1, color: AppColors.fifthColor),
              borderRadius: BorderRadius.circular(60),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 1, color: AppColors.fifthColor),
              borderRadius: BorderRadius.circular(60),
            ),
            fillColor: AppColors.white,
            filled: true,
            contentPadding: const EdgeInsets.all(20),
            hintText: hintText,
          ),
          maxLines: 1,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ));
  }
}
