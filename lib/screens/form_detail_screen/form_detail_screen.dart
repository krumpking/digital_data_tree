import 'package:flutter/material.dart';

import '../../components/form_location_picker.dart';

class FormDetailScreen extends StatelessWidget {
  FormDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: const [
          SizedBox(
              height: 400,
              width: 150.0,
              child: FormLocationPicker(title: "Map"))
        ],
      ),
    );
  }
}
