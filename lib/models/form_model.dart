import 'package:digital_data_tree/models/elements_model.dart';

class FormModel {
  final String id;
  final String title;
  final String creatorId;
  final String adminId;
  final String date;
  final String desc;
  final List<dynamic> editNumbers;
  final List<dynamic> elements;

  FormModel(
      {required this.id,
      required this.title,
      required this.creatorId,
      required this.adminId,
      required this.date,
      required this.desc,
      required this.editNumbers,
      required this.elements});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'creatorId': creatorId,
      'adminId': adminId,
      'date': date,
      'title': title,
      'desc': desc,
      'editNumbers': editNumbers,
      'elements': elements
    };
  }

  factory FormModel.fromMap(int id, Map<dynamic, dynamic> map) {
    return FormModel(
      id: map['id'],
      title: map['title'],
      creatorId: map['creatorId'],
      adminId: map['adminId'],
      date: map['date'],
      desc: map['desc'],
      editNumbers: map['editNumbers'],
      elements: map['elements'],
    );
  }
}
