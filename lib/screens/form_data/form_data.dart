import 'package:digital_data_tree/app/app_const.dart';
import 'package:digital_data_tree/components/elements.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_table/flutter_expandable_table.dart';
import 'package:provider/provider.dart';

import '../../models/info_model.dart';
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

  @override
  Widget build(BuildContext context) {
    // var list = getProductFor(model: model);

    return Scaffold(
      body: Container(
        color: AppColors.primaryColor,
        child: Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: _buildExpandableTable(),
            )),
          ],
        ),
      ),
    );
  }

  // DISPLAYING CAPTURED INFORMATION
  ExpandableTable _buildExpandableTable() {
    // get info
    var info = context.read<FormInfoViewModel>().getFormInfo(widget.id);

    int COLUMN_COUNT = info.info[0].length;
    int ROW_COUNT = info.length;
    const int SUB_COLUMN_COUNT = 5;

    //Creation header
    ExpandableTableHeader subHeader = ExpandableTableHeader(
        firstCell: Container(
            color: AppColors.primaryColor,
            margin: EdgeInsets.all(1),
            child: Center(
                child: Text(
              'Expandable Column',
              style: textStyleSubItems(),
            ))),
        children: List.generate(
            SUB_COLUMN_COUNT,
            (index) => Container(
                color: AppColors.primaryColor,
                margin: EdgeInsets.all(1),
                child: Center(
                    child: Text(
                  'Sub Column $index',
                  style: textStyleSubItems(),
                )))));

    //Creation header
    ExpandableTableHeader header = ExpandableTableHeader(
        firstCell: Container(
            color: AppColors.primaryColor,
            margin: EdgeInsets.all(1),
            child: Center(
                child: Text(
              'Expandable\nTable',
              style: textStyleSubItems(),
            ))),
        children: List.generate(
            COLUMN_COUNT - 1,
            (index) => index == 6
                ? subHeader
                : Container(
                    color: AppColors.primaryColor,
                    margin: EdgeInsets.all(1),
                    child: Center(
                        child: Text(
                      'Column $index',
                      style: textStyleSubItems(),
                    )))));

    //Creation sub rows
    List<ExpandableTableRow> subTows1 = List.generate(
        ROW_COUNT,
        (rowIndex) => ExpandableTableRow(
              height: 30,
              firstCell: Container(
                  color: AppColors.primaryColor,
                  margin: EdgeInsets.all(1),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Sub Sub Row $rowIndex',
                      style: textStyleSubItems(),
                    ),
                  )),
              children: List<Widget>.generate(
                  COLUMN_COUNT + SUB_COLUMN_COUNT - 1,
                  (columnIndex) => Container(
                      color: AppColors.primaryColor,
                      margin: EdgeInsets.all(1),
                      child: Center(
                          child: Text(
                        'Cell $rowIndex:$columnIndex',
                        style: textStyleSubItems(),
                      )))),
            ));
    List<ExpandableTableRow> subTows = List.generate(
        ROW_COUNT,
        (rowIndex) => ExpandableTableRow(
            height: 50,
            firstCell: Container(
                color: AppColors.primaryColor,
                margin: EdgeInsets.all(1),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Sub Row $rowIndex',
                      style: textStyleSubItems(),
                    ),
                  ),
                )),
            children: subTows1,
            legend: Container(
              color: AppColors.primaryColor,
              margin: EdgeInsets.all(1),
              child: Center(
                child: Text(
                  'Expandible sub Row...',
                  style: textStyleSubItems(),
                ),
              ),
            )));
    //Creation rows
    List<ExpandableTableRow> rows = List.generate(
        ROW_COUNT,
        (rowIndex) => ExpandableTableRow(
              height: 50,
              firstCell: Container(
                  color: AppColors.primaryColor,
                  margin: EdgeInsets.all(1),
                  child: Center(
                      child: Text(
                    'Row $rowIndex',
                    style: textStyleSubItems(),
                  ))),
              legend: rowIndex == 0
                  ? Container(
                      color: AppColors.primaryColor,
                      margin: EdgeInsets.all(1),
                      child: Center(
                        child: Text(
                          'Expandible Row...',
                          style: textStyleSubItems(),
                        ),
                      ),
                    )
                  : null,
              children: rowIndex == 0
                  ? subTows
                  : List<Widget>.generate(
                      COLUMN_COUNT + SUB_COLUMN_COUNT - 1,
                      (columnIndex) => Container(
                          color: AppColors.primaryColor,
                          margin: EdgeInsets.all(1),
                          child: Center(
                              child: Text(
                            'Cell $rowIndex:$columnIndex',
                            style: textStyleSubItems(),
                          )))),
            ));

    return ExpandableTable(
      rows: rows,
      header: header,
      scrollShadowColor: Colors.grey,
    );
  }

  TextStyle textStyleSubItems() {
    return const TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
  }
}
