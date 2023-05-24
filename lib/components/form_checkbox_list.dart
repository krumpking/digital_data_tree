import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_const.dart';
import '../view_models/form_info_view_model.dart';

class FormCheckBoxList extends StatefulWidget {
  const FormCheckBoxList({Key? key, required this.items, required this.label})
      : super(key: key);
  final List<String> items;
  final String label;
  @override
  _FormCheckBoxListState createState() => _FormCheckBoxListState();
}

class _FormCheckBoxListState extends State<FormCheckBoxList> {
  final List<String> chosenItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//  Create the SelectionButton widget in the next step.
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        itemCount: widget.items.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            activeColor: AppColors.primaryColor,
            title: Text(
              widget.items[index],
            ),
            value: chosenItems.contains(widget.items[index]),
            onChanged: (val) {
              if (val != null) {
                if (val) {
                  chosenItems.add(widget.items[index]);
                } else {
                  chosenItems.removeAt(index);
                }

                context.read<FormInfoViewModel>().addInfo(
                    {'label': widget.label, 'info': chosenItems.join(",")});
                setState(() {});
              }
            },
          );
        },
      ),
    ));
  }
}
