import 'dart:convert';

class Info {
  final String? title;
  final String? descr;
  final String infoId;
  final int encryption;
  final String dateCreated;
  final List<dynamic> info;
  final String editorId;
  final String adminId;

  Info(
      {this.title,
      this.descr,
      required this.encryption,
      required this.infoId,
      required this.dateCreated,
      required this.info,
      required this.editorId,
      required this.adminId});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'descr': descr,
      'infoId': infoId,
      'adminId': adminId,
      'encryption': encryption,
      'dateCreated': dateCreated,
      'info': info.map((e) => jsonEncode(e)).toList(),
      'editorId': editorId,
    };
  }

  factory Info.fromMap(Map<dynamic, dynamic> map) {
    return Info(
      title: map['title'],
      descr: map['descr'],
      infoId: map['infoId'],
      adminId: map['adminId'],
      encryption: map['encryption'],
      dateCreated: map['dateCreated'],
      info: map['info'].map((e) => jsonDecode(e) as Object).toList(),
      editorId: map['editorId'],
    );
  }
}
