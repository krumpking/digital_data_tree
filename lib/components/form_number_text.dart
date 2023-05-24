import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_const.dart';
import '../view_models/form_info_view_model.dart';

class FormNumberText {
  static numberText(
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
                .addInfo({'label': label, 'info': value});
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
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ));
  }
}
