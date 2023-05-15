import 'package:digital_data_tree/components/elements.dart';
import 'package:flutter/material.dart';

class FormCaptureInfoScreen extends StatefulWidget {
  const FormCaptureInfoScreen({Key? key}) : super(key: key);

  @override
  State<FormCaptureInfoScreen> createState() => _FFormCaptureInfoScreenState();
}

class _FFormCaptureInfoScreenState extends State<FormCaptureInfoScreen> {
  List<dynamic> list = [
    {
      'elementId': 0,
      'id': 'x',
      'label': 'Label',
      'arg1': 'Label',
      'arg2': 'Label',
      'arg3': 'Label'
    },
    {
      'elementId': 1,
      'id': 'x',
      'label': 'Long story',
      'arg1': 'Long story',
      'arg2': 'Long story',
      'arg3': 'Long story'
    },
    {
      'elementId': 2,
      'id': 'x',
      'label': 'Phone',
      'arg1': 'Phone',
      'arg2': 'Phone',
      'arg3': 'Phone'
    },
    {
      'elementId': 3,
      'id': 'x',
      'label': 'Email',
      'arg1': 'Email',
      'arg2': 'Email',
      'arg3': 'Email'
    },
    {
      'elementId': 4,
      'id': 'x',
      'label': 'Password',
      'arg1': 'Password',
      'arg2': 'Password',
      'arg3': 'Password'
    },
    {
      'elementId': 5,
      'id': 'x',
      'label': 'Multi choice',
      'arg1': ['cake', 'ice cream', 'cheese', 'ice cream', 'cheese'],
      'arg2': ['cake', 'ice cream', 'cheese', 'ice cream', 'cheese'],
      'arg3': ['cake', 'ice cream', 'cheese', 'ice cream', 'cheese']
    },
    {
      'elementId': 6,
      'id': 'x',
      'label': 'CheckList',
      'arg1': ['cake', 'ice cream', 'cheese'],
      'arg2': ['cake', 'ice cream', 'cheese'],
      'arg3': ['cake', 'ice cream', 'cheese']
    },
    {
      'elementId': 7,
      'id': 'x',
      'label': 'Time',
      'arg1': null,
      'arg2': null,
      'arg3': null
    },
    {
      'elementId': 8,
      'id': 'x',
      'label': 'Week',
      'arg1': null,
      'arg2': null,
      'arg3': null
    },
    {
      'elementId': 9,
      'id': 'x',
      'label': 'Month',
      'arg1': null,
      'arg2': null,
      'arg3': null
    },
    {
      'elementId': 10,
      'id': 'x',
      'label': 'Date',
      'arg1': null,
      'arg2': null,
      'arg3': null
    },
    {
      'elementId': 11,
      'id': 'x',
      'label': 'Image',
      'arg1': null,
      'arg2': null,
      'arg3': null
    },
    {
      'elementId': 12,
      'id': 'x',
      'label': 'Video',
      'arg1': null,
      'arg2': null,
      'arg3': null
    },
    {
      'elementId': 13,
      'id': 'x',
      'label': 'File',
      'arg1': null,
      'arg2': null,
      'arg3': null
    },
    {
      'elementId': 14,
      'id': 'x',
      'label': 'Color',
      'arg1': null,
      'arg2': null,
      'arg3': null
    },
    {
      'elementId': 15,
      'id': 'x',
      'label': 'Range',
      'arg1': 0,
      'arg2': 0.0,
      'arg3': 10.0
    },
    {
      'elementId': 16,
      'id': 'x',
      'label': 'Pick Location',
      'arg1': 0,
      'arg2': 0.0,
      'arg3': 10.0
    },
    {
      'elementId': 17,
      'id': 'x',
      'label': 'Put Signature',
      'arg1': null,
      'arg2': null,
      'arg3': null
    },
    {
      'elementId': 18,
      'id': 'x',
      'label': 'Put Text Recognition',
      'arg1': null,
      'arg2': null,
      'arg3': null
    },
    {
      'elementId': 19,
      'id': 'x',
      'label': 'Get Barcode reader',
      'arg1': null,
      'arg2': null,
      'arg3': null
    },
    {
      'elementId': 20,
      'id': 'x',
      'label': 'Get QRCode reader',
      'arg1': null,
      'arg2': null,
      'arg3': null
    },
  ];
  var currentCategory = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                    child: Text('${list[index]['label']}'),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    constraints: BoxConstraints(maxHeight: height / 5),
                    child: elementList[list[index]['elementId']](
                        list[index]['label'],
                        list[index]['arg2'],
                        list[index]['arg3'],
                        context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
