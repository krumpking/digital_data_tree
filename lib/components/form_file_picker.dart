import 'dart:io';

import 'package:digital_data_tree/components/app_buttons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../app/app_const.dart';
import '../view_models/form_info_view_model.dart';

class FormFilePicker {
  static filePicker({required String label, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AppButton.normalButton(
        title: 'Pick File',
        onPress: () async {
          final result =
              await FilePicker.platform.pickFiles(allowMultiple: false);

          // if no file is picked
          if (result == null) return;

          // we will log the name, size and path of the
          // first picked file (if multiple are selected)
          // print(result.files.first.name);
          // print(result.files.first.size);
          // print(result.files.first.path);
          // pickedFile = result;
          var info =
              Provider.of<FormInfoViewModel>(context, listen: false).info;
          context.read<FormInfoViewModel>().addInfo(
              {'label': label, 'info': result.files.first.path}, info.length);
        },
      ),
    );
  }
}
