import 'package:flutter/material.dart';

import '../app/app_const.dart';

class FormPasswordText {
  static String password = "";
  static passwordText({required String hintText, required String label}) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          obscureText: true,
          onChanged: (value) {
            password = value;
          },
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
          validator: (value) {
            if (value != null) {
              if (value.isEmpty) {
              } else {
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'ensure you are adding an email ';
                }
              }
            }
            return null;
          },
        ));
  }
}
