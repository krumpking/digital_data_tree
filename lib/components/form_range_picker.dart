import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_const.dart';
import '../view_models/form_info_view_model.dart';

class FormRangePicker extends StatefulWidget {
  const FormRangePicker(
      {Key? key, required this.min, required this.max, required this.label})
      : super(key: key);

  final double min;
  final double max;
  final String label;

  @override
  FormRangePickerState createState() => FormRangePickerState();
}

class FormRangePickerState extends State<FormRangePicker> {
  dynamic range;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.black,
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: RangeSlider(
        inactiveColor: Colors.grey,
        activeColor: AppColors.primaryColor,
        values: range ?? const RangeValues(0, 10),
        min: widget.min,
        max: widget.max,
        divisions: 5,
        labels: RangeLabels(
          widget.min.toString(),
          widget.max.toString(),
        ),
        onChanged: (RangeValues values) {
          setState(() {
            range = values;
          });
          var info =
              Provider.of<FormInfoViewModel>(context, listen: false).info;
          context.read<FormInfoViewModel>().addInfo({
            'label': widget.label,
            'info': '${values.start} - ${values.end}'
          }, info.length);
        },
      ),
    ));
  }

  static rangePicker(double min, double max, int divs) {
    return;
  }
}
