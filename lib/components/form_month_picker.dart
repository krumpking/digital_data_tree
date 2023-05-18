import 'package:digital_data_tree/components/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_const.dart';
import '../view_models/form_info_view_model.dart';
import 'month_picker.dart';

class FormMonthPicker {
  static monthPicker(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AppButton.normalButton(
        title: 'Pick Month',
        onPress: () async {
          final selectedDate = await showMonthPicker(
            context: context,
            initialDate: DateTime.now(), // Today's date
            firstDate: DateTime(2000, 5), // Stating date : May 2000
            lastDate: DateTime(2050), // Ending date: Dec 2050
          );

          //monthPicked = selectedDate.toString();
          var info =
              Provider.of<FormInfoViewModel>(context, listen: false).info;
          context.read<FormInfoViewModel>().addInfo(
              {'label': label, 'info': selectedDate.toString()}, info.length);
        },
      ),
    );
  }
}
