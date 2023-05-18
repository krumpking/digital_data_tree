import 'package:sembast/sembast.dart';

class Info {
  final String id;
  final int encryption;
  final String dateCreated;
  final List<List<dynamic>> info;
  final String editorNumber;
  final String editorId;

  Info({
    required this.encryption,
    required this.id,
    required this.dateCreated,
    required this.info,
    required this.editorNumber,
    required this.editorId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'encryption': encryption,
      'dateCreated': dateCreated,
      'info': info,
      'editorNumber': editorNumber,
      'editorId': editorId
    };
  }

  factory Info.fromMap(int id, Map<dynamic, dynamic> map) {
    return Info(
      id: map['id'],
      encryption: map['encryption'],
      dateCreated: map['dateCreated'],
      editorId: map['editorId'],
      editorNumber: map['editorNumber'],
      info: map['info'],
    );
  }
}
