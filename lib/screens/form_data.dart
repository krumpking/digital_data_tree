import 'package:digital_data_tree/components/elements.dart';
import 'package:flutter/material.dart';

class FormDataScreen extends StatefulWidget {
  const FormDataScreen({Key? key}) : super(key: key);

  @override
  State<FormDataScreen> createState() => _FormDataScreenState();
}

class _FormDataScreenState extends State<FormDataScreen> {
  List<dynamic> list = [
    {
      'elementId': 0,
      'id': 'x',
      'label': 'Label',
      'arg1': '',
      'arg2': '',
      'arg3': ''
    },
    {
      'elementId': 0,
      'id': 'x',
      'label': 'Label',
      'arg1': '',
      'arg2': '',
      'arg3': ''
    },
    {
      'elementId': 0,
      'id': 'x',
      'label': 'Label',
      'arg1': '',
      'arg2': '',
      'arg3': ''
    },
  ];
  var currentCategory = 0;

  @override
  Widget build(BuildContext context) {
    // var list = getProductFor(model: model);

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${list[index]['label']}'),
                const SizedBox(height: 8.0),
                elementList[list[index]['elementId']](
                  list[index]['arg1'],
                  list[index]['arg2'],
                  list[index]['arg3'],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
