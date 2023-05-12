import 'package:flutter/cupertino.dart';

class FormInfo extends ChangeNotifier {
  List<Map<String, dynamic>> info = [];

  void addInfo(Map<String, dynamic> newInfo) {
    info.add(newInfo);
    notifyListeners();
  }

  void removeInfo(int index) {
    info.removeAt(index);
    notifyListeners();
  }
}
