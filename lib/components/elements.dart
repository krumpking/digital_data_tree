import 'package:digital_data_tree/components/app_buttons.dart';
import 'package:digital_data_tree/components/form_barcode_qr_scanner.dart';
import 'package:digital_data_tree/components/form_color_picker.dart';
import 'package:digital_data_tree/components/form_file_picker.dart';
import 'package:digital_data_tree/components/form_short.text.dart';
import 'package:digital_data_tree/components/form_signature.dart';
import 'package:digital_data_tree/components/form_text_recognition.dart';
import 'package:digital_data_tree/components/form_video_picker.dart';
import 'package:flutter/material.dart';

import 'form_checkbox_list.dart';
import 'form_date_picker.dart';
import 'form_drop_down.dart';
import 'form_email_text.dart';
import 'form_image_picker.dart';
import 'form_location_picker.dart';
import 'form_long_text.dart';
import 'form_month_picker.dart';
import 'form_number_text.dart';
import 'form_password_text.dart';
import 'form_range_picker.dart';
import 'form_time_picker.dart';
import 'form_week_picker.dart';

List<Widget Function(dynamic arg1, dynamic arg2, dynamic arg3, dynamic arg4)>
    elementList = [
  // Short Text 0
  (dynamic hintText, dynamic label, dynamic arg3, dynamic arg4) {
    return FormShortText.shortText(
        hintText: hintText, label: label, context: arg4);
  },
  // Long Text 1
  (dynamic hintText, dynamic label, dynamic arg3, dynamic arg4) {
    return FormLongText.longText(
        hintText: hintText, label: label, context: arg4);
  },
  // Number Text 2
  (dynamic hintText, dynamic label, dynamic arg3, dynamic arg4) {
    return FormNumberText.numberText(
        hintText: hintText, label: label, context: arg4);
  },
  //  Email text 3
  (dynamic hintText, dynamic label, dynamic arg3, dynamic arg4) {
    return FormEmailText.emailText(
        hintText: hintText, label: label, context: arg4);
  },
  // Password 4
  (dynamic hintText, dynamic label, dynamic arg3, dynamic arg4) {
    return FormPasswordText.passwordText(
        hintText: hintText, label: label, context: arg4);
  },
  // Multiple selection 5
  (dynamic label, dynamic items, dynamic arg3, dynamic arg4) {
    return FormDropdown(items: items, label: label);
  },
  // Checkbox 6
  (dynamic label, dynamic items, dynamic arg3, dynamic arg4) {
    return FormCheckBoxList(items: items, label: label);
  },
  // time 7
  (dynamic label, dynamic arg2, dynamic arg3, dynamic arg4) {
    return AppButton.normalButton(
        title: 'Pick Time',
        onPress: () {
          Navigator.of(arg4).push(MaterialPageRoute(
            builder: ((context) => FormTimePicker(label: label)),
          ));
        });
  },
  // week 8
  (dynamic label, dynamic arg2, dynamic arg3, dynamic arg4) {
    return FormWeekPicker.weekPicker(label: label, context: arg4);
  },
  // month 9
  (dynamic label, dynamic arg2, dynamic arg3, dynamic arg4) {
    return FormMonthPicker.monthPicker(arg4, label);
  },
  // date 10
  (dynamic label, dynamic arg2, dynamic arg3, dynamic arg4) {
    return FormDatePicker.datePicker(label: label, context: arg4);
  },
  // image
  (dynamic label, dynamic arg2, dynamic arg3, dynamic arg4) {
    return FormImagePicker.imagePicker(label: label);
  },
  // video
  (dynamic label, dynamic arg2, dynamic arg3, dynamic arg4) {
    return FormVideoPicker.videoPicker(label: label);
  },
  // file picker
  (dynamic label, dynamic arg2, dynamic arg3, dynamic arg4) {
    return FormFilePicker.filePicker(label: label);
  },
  // color picker
  (dynamic context, dynamic arg, dynamic arg3, dynamic arg4) {
    return FormColorPicker.colorPicker(context);
  },
  // range picker
  (dynamic min, dynamic max, dynamic label, dynamic arg4) {
    return FormRangePicker(max: max, min: min, label: label);
  },
  // location picker
  (dynamic label, dynamic arg2, dynamic arg3, dynamic arg4) {
    return FormLocationPicker(label: label);
  },
  // signature
  (dynamic label, dynamic arg2, dynamic arg3, dynamic arg4) {
    return FormSignature(label: label);
  },
  // Text recognition
  (dynamic label, dynamic arg2, dynamic arg3, dynamic arg4) {
    return TextRecognition(label: label);
  },
  // Barcode reader
  (dynamic label, dynamic arg2, dynamic arg3, dynamic arg4) {
    return BarQRcodeScannerPageView(label: label);
  },
  // QR Code reader
  (dynamic label, dynamic arg2, dynamic arg3, dynamic arg4) {
    return BarQRcodeScannerPageView(label: label);
  },
];
