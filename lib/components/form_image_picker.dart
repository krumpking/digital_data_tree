import 'package:digital_data_tree/components/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../app/app_const.dart';
import '../view_models/form_info_view_model.dart';

class FormImagePicker {
  static imagePicker({required String label, required BuildContext context}) {
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
          // image = pickedFile?.path;
          var info =
              Provider.of<FormInfoViewModel>(context, listen: false).info;
          context
              .read<FormInfoViewModel>()
              .addInfo({'label': label, 'info': pickedFile?.path}, info.length);
        },
      ),
    );
  }
}
