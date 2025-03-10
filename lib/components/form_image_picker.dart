import 'dart:io';

import 'package:digital_data_tree/components/app_buttons.dart';
import 'package:digital_data_tree/components/snack.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../app/app_const.dart';
import '../view_models/form_info_view_model.dart';

class FormImagePicker extends StatefulWidget {
  const FormImagePicker({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  FormImagePickerState createState() => FormImagePickerState();
}

class FormImagePickerState extends State<FormImagePicker> {
  String _image = "";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AppButton.normalButton(
        title: _image.isEmpty ? 'Pick Image' : _image, // ADD added here
        onPress: () async {
          if (context.mounted) {
            try {
              final ImagePicker _picker = ImagePicker();
              final XFile? pickedFile = await _picker.pickImage(
                source: ImageSource.gallery,
              );
              // image = pickedFile?.path;

              if (pickedFile != null) {
                File imageF = File(pickedFile.path);
                if (imageF.lengthSync() > 30 * 1024 * 1024) {
                  ScaffoldMessenger.of(context).showSnackBar(Snack.snackError(
                      'You can only pick images that are 30MB and below'));
                } else {
                  setState(() {
                    _image = "image picked, click to change";
                  });

                  context.read<FormInfoViewModel>().addInfo(
                    {
                      'label': widget.label,
                      'info': pickedFile.name,
                      'element': 11,
                      'filePath': pickedFile.path
                    },
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(Snack.snackError(
                    'There was an error picking image,please try again'));
              }
            } catch (e) {
              print(e);
            }
          }
        },
      ),
    );
  }
}
