import 'dart:io';

import 'package:digital_data_tree/components/app_buttons.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../app/app_const.dart';

class FormVideoPicker {
  static dynamic videoPicked;
  static videoPicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AppButton.normalButton(
        title: 'Pick Video',
        onPress: () async {
          final ImagePicker _picker = ImagePicker();
          final XFile? pickedFile = await _picker.pickVideo(
            source: ImageSource.gallery,
          );
          videoPicked = pickedFile;
        },
      ),
    );
  }
}
