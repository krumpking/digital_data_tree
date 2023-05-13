import 'package:digital_data_tree/view_models/form_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_const.dart';

class FormShortText {
  static shortText(
      {required String hintText,
      required String label,
      required BuildContext context}) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          onChanged: (value) {
            context.read<FormInfo>().addInfo({'label': label, 'info': value});
          },
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
        ));
  }
}
