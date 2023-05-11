import 'dart:convert';

import 'package:digital_data_tree/components/form_file_picker.dart';
import 'package:digital_data_tree/components/form_location_picker.dart';
import 'package:digital_data_tree/components/form_long_text.dart';
import 'package:digital_data_tree/components/form_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../components/app_buttons.dart';
import '../../components/form_date_picker.dart';
import '../../components/form_drop_down.dart';
import '../../components/form_email_text.dart';
import '../../components/form_image_picker.dart';
import '../../components/form_month_picker.dart';
import '../../components/form_number_text.dart';
import '../../components/form_password_text.dart';
import '../../components/form_range_picker.dart';
import '../../components/form_short.text.dart';
import '../../components/form_signature.dart';
import '../../components/form_text_recognition.dart';
import '../../components/form_video_picker.dart';
import '../../components/form_week_picker.dart';

class FormDetailScreen extends StatefulWidget {
  const FormDetailScreen({super.key});

  @override
  State<FormDetailScreen> createState() => _FormDetailScreenState();
}

class _FormDetailScreenState extends State<FormDetailScreen> {
  Map<dynamic, dynamic> _result = {};
  List<String> list = ['house', 'car', 'wife'];
  dynamic res;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(children: [
        const Text('Question'),
        SizedBox(
            height: size.height / 2,
            width: size.width,
            child: FormWeekPicker.weekPicker()),
        AppButton.normalButton(
            title: "Save",
            onPress: () {
              print('✅ ${FormWeekPicker.weekPicked}');
            })
      ]),
    );
  }
}
