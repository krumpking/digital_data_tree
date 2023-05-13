import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_const.dart';
import '../view_models/form_info.dart';

class FormTimePicker extends StatelessWidget {
  FormTimePicker({Key? key, required this.label}) : super(key: key);
  final String label;

  Time timerPicked = Time(hour: 11, minute: 30, second: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
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
              context.read<FormInfo>().addInfo({'label': label, 'info': p0});
              Navigator.pop(context);
            }),
            minuteInterval: TimePickerInterval.FIVE,
            iosStylePicker: true,
            minHour: 9,
            maxHour: 21,
            is24HrFormat: false,
          ),
        ));
  }
}
