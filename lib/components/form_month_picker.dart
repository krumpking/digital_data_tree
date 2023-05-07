import 'package:digital_data_tree/components/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_month_picker/flutter_month_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../app/app_const.dart';

class FormMonthPicker {
  static monthPicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AppButton.normalButton(
        title: 'Pick Month',
        onPress: () async {
          final selectedDate = showMonthPicker(
            context: context,
            initialDate: DateTime.now(), // Today's date
            firstDate: DateTime(2000, 5), // Stating date : May 2000
            lastDate: DateTime(2050), // Ending date: Dec 2050
          );
        },
      ),
    );
  }
}
