import 'package:digital_data_tree/models/info_model.dart';
import 'package:flutter/cupertino.dart';

import '../models/form_model.dart';

class FormInfoViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> info = [];
  int currentIndex = 0;
  int infoFinalIndex = 0;
  List<Info> infoFinal = [];

  void createInfoArray(List<Map<String, dynamic>> expectedInfo) {
    for (var element in expectedInfo) {
      info.add(element);
    }

    notifyListeners();
  }

  // Add information to labels
  void addInfo(Map<String, dynamic> newInfo) {
    if (check(newInfo['label'])) {
      info[currentIndex] = {
        'label': newInfo['label'],
        'info': newInfo['info'],
        'element': newInfo['element']
      };
    } else {
      info.add(newInfo);
    }

    notifyListeners();
  }

  // Add the whole Object of Form info
  void addInfoFinal(Info info) {
    if (checkFinal(info.infoId)) {
      var currInfo = infoFinal[infoFinalIndex].info;
      Info particularForm = Info(
          title: infoFinal[infoFinalIndex].title,
          descr: infoFinal[infoFinalIndex].descr,
          dateCreated: infoFinal[infoFinalIndex].dateCreated,
          editorId: infoFinal[infoFinalIndex].editorId,
          encryption: 1,
          infoId: infoFinal[infoFinalIndex].infoId,
          info: info.info);

      infoFinal[infoFinalIndex] = particularForm;
    } else {
      infoFinal.add(info);
    }
  }

  void removeInfo(int index) {
    info.removeAt(index);
    notifyListeners();
  }

  void removeAllInfo() {
    info = [];
    notifyListeners();
  }

  Info getFormInfo(String id) {
    Info particularForm = Info(
        title: "",
        descr: "",
        dateCreated: '',
        editorId: '',
        encryption: 0,
        infoId: "",
        info: []);

    for (var element in infoFinal) {
      if (element.infoId == id) {
        particularForm = element;
      }
    }

    return particularForm;
  }

  bool check(String label) {
    bool res = false;

    if (info.isNotEmpty) {
      for (var i = 0; i < info.length; i++) {
        var map = info[i];
        if (map['label'] == label) {
          // If the variable is present in the map, set the variableExists variable to true.
          res = true;
          currentIndex = i;
          break;
        }
      }
    }

    return res;
  }

  bool checkFinal(String id) {
    bool res = false;

    for (var i = 0; i < infoFinal.length; i++) {
      var map = infoFinal[i];
      if (map.infoId == id) {
        // If the variable is present in the map, set the variableExists variable to true.
        res = true;
        infoFinalIndex = i;
        break;
      }
    }

    return res;
  }
}
