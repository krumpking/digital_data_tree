import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../app/app_const.dart';
import '../view_models/form_info_view_model.dart';

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
            value: Time(hour: 12, minute: 00, second: 00),
            onChange: ((p0) {
              timerPicked = p0;

              context.read<FormInfoViewModel>().addInfo({
                'label': label,
                'info': '${p0.hour}:${p0.minute}:${p0.second}'
              });

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
