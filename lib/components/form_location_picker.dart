import 'dart:io';

import 'package:digital_data_tree/components/app_buttons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_location_picker/map_location_picker.dart';

import '../app/app_const.dart';

class FormLocationPicker {
  static locationPicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AppButton.normalButton(
        title: 'Pick Location',
        onPress: () async {},
      ),
    );
  }
}
