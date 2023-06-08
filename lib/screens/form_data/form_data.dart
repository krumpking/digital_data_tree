import 'dart:convert';

import 'package:digital_data_tree/app/app_const.dart';
import 'package:digital_data_tree/components/app_buttons.dart';
import 'package:digital_data_tree/components/elements.dart';
import 'package:digital_data_tree/components/loader.dart';
import 'package:digital_data_tree/repositories_abstracts/info_repository.dart';
import 'package:digital_data_tree/utils/arrayM.dart';
import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../components/snack.dart';
import '../../models/info_model.dart';
import '../../utils/crypto.dart';
import '../../view_models/form_info_view_model.dart';

class FormDataScreen extends StatefulWidget {
  const FormDataScreen({super.key, required this.id});
  final String id;

  @override
  State<FormDataScreen> createState() => _FormDataScreenState();
}

class _FormDataScreenState extends State<FormDataScreen> {
  List<dynamic> list = [
    {'elementId': 0, 'label': 'Label', 'arg1': 'Label', 'arg2': '', 'arg3': ''},
  ];
  var currentCategory = 0;
  final InfoRepository _infoRepository = GetIt.I.get();
  List<dynamic> _info = [];
  bool _loading = true;
  List<String> _headers = [];
  List<List<String>> _rows = [];
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getInfo();
  }

  @override
  Widget build(BuildContext context) {
    // var list = getProductFor(model: model);
    // var info = context.read<FormInfoViewModel>().getFormInfo(widget.id);
    // int COLUMN_COUNT = info.info[0].length;
    // int ROW_COUNT = info.info.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('Data'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Card(
        child: _loading
            ? const Loader()
            : _info.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          headingRowColor:
                              MaterialStateProperty.all(AppColors.primaryColor),
                          columns: _headers
                              .map((header) => DataColumn(
                                    label: Text(
                                      header,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ))
                              .toList(),
                          rows: _rows
                              .map((row) => DataRow(
                                  cells: row
                                      .map((cell) => DataCell(onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Colors.white,
                                                    // title: Text(
                                                    //     'Update ${cell.length > 2500 ? "Signature Captured" : cell}'),
                                                    content: Text(cell),
                                                    // actions: [
                                                    //   AppButton.normalButton(
                                                    //     title:
                                                    //         'Update ${cell.length > 2500 ? "Signature Captured" : cell}',
                                                    //     onPress: () {
                                                    //       // Close the dialog

                                                    //       Map<String, dynamic>
                                                    //           d = _info[0].info[
                                                    //               _rows.indexOf(
                                                    //                   row)];

                                                    //       Navigator.pop(
                                                    //           context);
                                                    //     },
                                                    //   ),
                                                    //   AppButton.normalButton(
                                                    //     title: 'Cancel',
                                                    //     onPress: () {
                                                    //       // Close the dialog
                                                    //       Navigator.pop(
                                                    //           context);
                                                    //     },
                                                    //   ),
                                                    // ],
                                                  );
                                                });
                                          },
                                              Text(
                                                cell.length > 2500
                                                    ? "Signature Captured"
                                                    : cell,
                                              )))
                                      .toList()))
                              .toList(),
                        )))
                : const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        'Looks like you are yet to collect any information / or you uploaded the information to the cloud'),
                  ),
      ),
    );
  }

  void _getInfo() async {
    _info = await _infoRepository.getInfo(widget.id);

    if (_info.isNotEmpty) {
      Map<String, dynamic> map = _info[0].info[0];
      final object = map['data'];

      for (var i = 0; i < object.length; i++) {
        var label = object[i]['label'];
        _headers.add(label);
      }

      for (var i = 0; i < _info[0].info.length; i++) {
        _rows.add(_getCells(i, object));
      }
    }

    setState(() {
      _loading = false;
    });
  }

  List<String> _getCells(int i, List<dynamic> object) {
    List<String> cell = [];
    for (var j = 0; j < object.length; j++) {
      String v = "";
      if (ArrayM.isIndexOutOfRange(j, _info[0].info[i]['data'].length)) {
        v = "n/a";
        cell.add(v);
      } else {
        v = _info[0].info[i]['data'][j]['info'];
        if (v.isEmpty) {
          cell.add("");
        } else {
          cell.add(dencrypt(v));
        }
      }
    }
    return cell;
  }

  TextStyle textStyleSubItems() {
    return const TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
  }

  String dencrypt(String info) {
    return Encryption.decrypt(info, widget.id + widget.id + widget.id);
  }

  Widget _buildEditDialog(
      ExpandableRow row, Function(ExpandableRow) onSuccess) {
    return AlertDialog(
      title: SizedBox(
        height: 300,
        child: TextButton(
          child: const Text("Change name"),
          onPressed: () {
            row.cells[1].value = "x3";
            onSuccess(row);
          },
        ),
      ),
    );
  }
}
