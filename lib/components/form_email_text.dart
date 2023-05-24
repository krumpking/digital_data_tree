import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_const.dart';
import '../view_models/form_info_view_model.dart';

class FormEmailText {
  static emailText(
      {required String hintText,
      required String label,
      required BuildContext context}) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          cursorColor: AppColors.fifthColor,
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
              if (value.isNotEmpty) {
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'ensure you are adding an email ';
                }
              }
            }
            return null;
          },
          onChanged: (value) {
            context
                .read<FormInfoViewModel>()
                .addInfo({'label': label, 'info': value});
          },
        ));
  }
}
