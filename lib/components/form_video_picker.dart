import 'dart:io';

import 'package:digital_data_tree/components/app_buttons.dart';
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
          final XFile? pickedFile = await _picker.pickVideo(
            source: ImageSource.gallery,
          );
          // videoPicked = pickedFile;

          setState(() {
            _video = pickedFile != null
                ? "video picked, click to change"
                : "no file";
          });

          context
              .read<FormInfoViewModel>()
              .addInfo({'label': widget.label, 'info': pickedFile?.path});
        },
      ),
    );
  }
}
