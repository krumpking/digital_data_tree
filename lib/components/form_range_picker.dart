import 'dart:io';

import 'package:digital_data_tree/components/app_buttons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';

import '../app/app_const.dart';

class FormRangePicker {
  static rangePicker(double min, double max, int divs) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: RangeSlider(
        activeColor: AppColors.primaryColor,
        values: RangeValues(min, max),
        min: min,
        max: max,
        divisions: 5,
        labels: RangeLabels(
          min.toString(),
          max.toString(),
        ),
        onChanged: (RangeValues values) {},
      ),
    );
  }
}
