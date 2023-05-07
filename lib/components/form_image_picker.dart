import 'package:digital_data_tree/components/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../app/app_const.dart';

class FormImagePicker {
  static imagePicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AppButton.normalButton(
        title: 'Pick Image',
        onPress: () async {
          final ImagePicker _picker = ImagePicker();
          final XFile? pickedFile = await _picker.pickImage(
            source: ImageSource.gallery,
            maxWidth: 2,
            maxHeight: 2,
            imageQuality: 100,
          );
        },
      ),
    );
  }
}
