import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';

import '../app/app_const.dart';

class FormTimePicker {
  static Time timerPicked = Time(hour: 11, minute: 30, second: 20);
  static timePicker({required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: showPicker(
        accentColor: AppColors.primaryColor,
        okStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: AppColors.primaryColor),
        cancelStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: AppColors.primaryColor),
        isInlinePicker: true,
        elevation: 1,
        value: Time(hour: 11, minute: 30, second: 20),
        onChange: ((p0) {
          timerPicked = p0;
        }),
        minuteInterval: TimePickerInterval.FIVE,
        iosStylePicker: true,
        minHour: 9,
        maxHour: 21,
        is24HrFormat: false,
      ),
    );
  }
}
