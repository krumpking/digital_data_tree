import 'package:sembast/sembast.dart';

class Info {
  final int id;
  final String dateCreated;
  final List<dynamic> info;
  final List<dynamic> editorNumber;
  final String editorId;

  Info({
    required this.id,
    required this.dateCreated,
    required this.info,
    required this.editorNumber,
    required this.editorId,
  });

  Map<String, dynamic> toMap() {
    return {
      'dateCreated': dateCreated,
      'info': info,
      'editorNumber': editorNumber,
      'editorId': editorId
    };
  }

  factory Info.fromMap(int id, Map<dynamic, dynamic> map) {
    return Info(
      id: id,
      dateCreated: map['dateCreated'],
      editorId: map['editorId'],
      editorNumber: map['editorNumber'],
      info: map['info'],
    );
  }
}
