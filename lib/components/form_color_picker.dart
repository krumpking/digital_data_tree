import 'dart:io';

import 'package:digital_data_tree/components/app_buttons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';

import '../app/app_const.dart';

class FormColorPicker {
  static colorPicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AppButton.normalButton(
        title: 'Pick Color',
        onPress: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                titlePadding: const EdgeInsets.all(0),
                contentPadding: const EdgeInsets.all(0),
                content: SingleChildScrollView(
                  child: MaterialPicker(
                    pickerColor: Colors.white,
                    onColorChanged: (colorValue) {
                      // color = colorValue.value.toRadixString(16);
                    },
                    enableLabel: true,
                    portraitOnly: false,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
