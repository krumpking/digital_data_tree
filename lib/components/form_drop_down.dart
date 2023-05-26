import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_const.dart';
import '../view_models/form_info_view_model.dart';

class FormDropdown extends StatefulWidget {
  const FormDropdown({Key? key, required this.items, required this.label})
      : super(key: key);
  final List<String> items;
  final String label;

  @override
  FormDropdownState createState() => FormDropdownState();
}

class FormDropdownState extends State<FormDropdown> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    widget.items;

    return Scaffold(
        // backgroundColor: Colors.black,
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButton(
        // Initial Value
        value: widget.items[_selectedIndex].toString(),
        hint: const Text("Select"),
        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: widget.items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(fontSize: 15),
            ),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          setState(() {
            _selectedIndex = widget.items.indexOf(newValue!);
          });

          context
              .read<FormInfoViewModel>()
              .addInfo({'label': widget.label, 'info': newValue, 'element': 5});
        },
      ),
    ));
  }
}
