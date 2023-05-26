import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_const.dart';
import '../view_models/form_info_view_model.dart';

class FormLongText {
  static longText(
      {required String hintText,
      required String label,
      required BuildContext context}) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          cursorColor: AppColors.fifthColor,
          onChanged: (value) {
            context
                .read<FormInfoViewModel>()
                .addInfo({'label': label, 'info': value, 'element': 1});
          },
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
