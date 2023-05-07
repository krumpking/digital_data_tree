import 'package:flutter/material.dart';

import '../../components/form_location_picker.dart';

class FormDetailScreen extends StatelessWidget {
  FormDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [FormLocationPicker.locationPicker(context)],
      ),
    );
  }
}
