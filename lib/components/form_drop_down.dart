import 'package:flutter/material.dart';

import '../app/app_const.dart';

class FormDropdown {
  static dropdown({required String dropdownvalue, required dynamic items}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButton(
        // Initial Value
        value: dropdownvalue,

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: items.map<DropdownMenuItem<String>>((String value) {
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
        onChanged: (String? newValue) {},
      ),
    );
  }
}
