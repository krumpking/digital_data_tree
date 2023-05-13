import 'package:flutter/cupertino.dart';

class FormInfo extends ChangeNotifier {
  List<Map<String, dynamic>> info = [];
  int currentIndex = 0;

  void addInfo(Map<String, dynamic> newInfo) {
    if (check(newInfo['label'])) {
      info[currentIndex] = {'label': newInfo['label'], 'info': newInfo['info']};
    } else {
      info.add(newInfo);
    }

    notifyListeners();
  }

  void removeInfo(int index) {
    info.removeAt(index);
    notifyListeners();
  }

  bool check(String label) {
    bool res = false;

    for (var i = 0; i < info.length; i++) {
      var map = info[i];
      if (map['label'] == label) {
        // If the variable is present in the map, set the variableExists variable to true.
        res = true;
        currentIndex = i;
        break;
      }
    }

    return res;
  }
}
