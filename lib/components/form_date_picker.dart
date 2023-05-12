import 'package:digital_data_tree/components/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_month_picker/flutter_month_picker.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../app/app_const.dart';

class FormDatePicker {
  static datePicker({required String label}) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          height: 250,
          child: ScrollDatePicker(
            selectedDate: DateTime.now(),
            locale: Locale('en'),
            onDateTimeChanged: (DateTime value) {
              // date = value.toString();
            },
          ),
        ));
  }
}
