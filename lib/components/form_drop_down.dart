import 'package:flutter/material.dart';

import '../app/app_const.dart';

class FormDropdown extends StatefulWidget {
  const FormDropdown({Key? key, required this.items, required this.label})
      : super(key: key);
  final List<String> items;
  final String label;

  @override
  FormDropdownState createState() => FormDropdownState();
}

class FormDropdownState extends State<FormDropdown> {
  String selected = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButton(
          // Initial Value
          value: selected.isEmpty ? widget.items[0] : selected,
          hint: const Text("Select"),
          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),

          // Array list of items
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(fontSize: 30),
              ),
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (String? newValue) {
            selected = newValue!;
            setState(() {});
          },
        ),
      ),
    );
  }
}
