import 'dart:io';

import 'package:digital_data_tree/components/app_buttons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../app/app_const.dart';
import '../view_models/form_info_view_model.dart';

class FormColorPicker extends StatefulWidget {
  const FormColorPicker({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  FormColorPickerState createState() => FormColorPickerState();
}

class FormColorPickerState extends State<FormColorPicker> {
  String _pickedColor = "";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AppButton.normalButton(
        title: _pickedColor.isEmpty
            ? 'Pick Color'
            : 'Picked $_pickedColor ,tap to change',
        onPress: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Tap the color you want",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                titlePadding: const EdgeInsets.all(0),
                contentPadding: const EdgeInsets.all(0),
                content: SingleChildScrollView(
                  child: MaterialPicker(
                    pickerColor: Colors.white,
                    onColorChanged: (colorValue) {
                      // color = colorValue.value.toRadixString(16);

                      setState(() {
                        _pickedColor = colorValue.value.toRadixString(16);
                      });

                      context.read<FormInfoViewModel>().addInfo({
                        'label': widget.label,
                        'info': colorValue.value.toRadixString(16),
                        'element': 14
                      });
                    },
                    enableLabel: true,
                    portraitOnly: false,
                  ),
                ),
                actions: [
                  AppButton.normalButton(
                      title: 'Done', onPress: () => Navigator.pop(context))
                ],
              );
            },
          );
        },
      ),
    );
  }
}
