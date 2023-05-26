import 'dart:io';

import 'package:digital_data_tree/components/app_buttons.dart';
import 'package:digital_data_tree/components/snack.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../app/app_const.dart';
import '../view_models/form_info_view_model.dart';

class FormVideoPicker extends StatefulWidget {
  const FormVideoPicker({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  FormVideoPickerState createState() => FormVideoPickerState();
}

class FormVideoPickerState extends State<FormVideoPicker> {
  String _video = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AppButton.normalButton(
        title: _video.isEmpty ? 'Pick Video' : _video,
        onPress: () async {
          final ImagePicker _picker = ImagePicker();
          final XFile? pickedFile =
              await _picker.pickVideo(source: ImageSource.gallery);
          // videoPicked = pickedFile;

          if (pickedFile != null) {
            File videoF = File(pickedFile.path);

            if (videoF.lengthSync() > 30 * 1024 * 1024) {
              ScaffoldMessenger.of(context).showSnackBar(Snack.snackError(
                  'You can only select videos less than 30MB in size'));
            } else {
              setState(() {
                _video = pickedFile != null
                    ? "video picked, click to change"
                    : "no file";
              });

              context.read<FormInfoViewModel>().addInfo({
                'label': widget.label,
                'info': pickedFile.name,
                'element': 12,
                'filePath': pickedFile.path
              });
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(Snack.snackError(
                'There was an error picking video, please try again'));
          }
        },
      ),
    );
  }
}
