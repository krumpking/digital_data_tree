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

List<Widget Function(dynamic arg1, dynamic arg2, dynamic arg3)> elementList = [
  // Short Text
  (dynamic hintText, dynamic label, dynamic arg3) {
    return FormShortText.shortText(hintText: hintText, label: label);
  },
  // Long Text
  (dynamic hintText, dynamic label, dynamic arg3) {
    return FormLongText.longText(hintText: hintText, label: label);
  },
  // Number Text
  (dynamic hintText, dynamic label, dynamic arg3) {
    return FormNumberText.numberText(hintText: hintText, label: label);
  },
  //  Email text
  (dynamic hintText, dynamic label, dynamic arg3) {
    return FormEmailText.emailText(hintText: hintText, label: label);
  },
  // Password
  (dynamic hintText, dynamic label, dynamic arg3) {
    return FormPasswordText.passwordText(hintText: hintText, label: label);
  },
  // Multiple selection
  (dynamic items, dynamic label, dynamic arg3) {
    return FormDropdown(items: items, label: label);
  },
  // Checkbox
  (dynamic items, dynamic label, dynamic arg3) {
    return FormCheckBoxList(items: items, label: label);
  },
  // time
  (dynamic label, dynamic arg2, dynamic arg3) {
    return FormTimePicker.timePicker(label: label);
  },
  // week
  (dynamic label, dynamic arg2, dynamic arg3) {
    return FormWeekPicker.weekPicker(label: label);
  },
  // month
  (dynamic context, dynamic label, dynamic arg3) {
    return FormMonthPicker.monthPicker(context, label);
  },
  // date
  (dynamic label, dynamic arg2, dynamic arg3) {
    return FormDatePicker.datePicker(label: label);
  },
  // image
  (dynamic label, dynamic arg2, dynamic arg3) {
    return FormImagePicker.imagePicker(label: label);
  },
  // video
  (dynamic label, dynamic arg2, dynamic arg3) {
    return FormVideoPicker.videoPicker(label: label);
  },
  // file picker
  (dynamic label, dynamic arg2, dynamic arg3) {
    return FormFilePicker.filePicker(label: label);
  },
  // color picker
  (dynamic context, dynamic arg, dynamic arg3) {
    return FormColorPicker.colorPicker(context);
  },
  // range picker
  (dynamic min, dynamic max, dynamic label) {
    return FormRangePicker(max: max, min: min, label: label);
  },
  // location picker
  (dynamic label, dynamic arg2, dynamic arg3) {
    return FormLocationPicker(label: label);
  },
  // signature
  (dynamic label, dynamic arg2, dynamic arg3) {
    return FormSignature(label: label);
  },
  // Text recognition
  (dynamic label, dynamic arg2, dynamic arg3) {
    return TextRecognition(label: label);
  },
  // Barcode reader
  (dynamic label, dynamic arg2, dynamic arg3) {
    return BarQRcodeScannerPageView(label: label);
  },
  // QR Code reader
  (dynamic label, dynamic arg2, dynamic arg3) {
    return BarQRcodeScannerPageView(label: label);
  },
];
