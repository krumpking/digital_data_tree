import 'package:flutter/material.dart';

import '../app/app_const.dart';

class FormCheckBoxList {
  static checkboxlist({required dynamic items}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        itemCount: items.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(
              items[index],
            ),
            value: true,
            onChanged: (val) {
              // setState(
              //   () {
              //     _data[index].isSelected = val;
              //   },
              // );
            },
          );
        },
      ),
    );
  }
}
