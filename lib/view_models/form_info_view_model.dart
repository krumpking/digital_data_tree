import 'package:digital_data_tree/models/info_model.dart';
import 'package:flutter/cupertino.dart';

import '../models/form_model.dart';

class FormInfoViewModel extends ChangeNotifier {
  List<List<Map<String, dynamic>>> info = [];
  int currentIndex = 0;
  int infoFinalIndex = 0;
  List<Info> infoFinal = [];

  // Add information to labels
  void addInfo(Map<String, dynamic> newInfo, int index) {
    if (check(newInfo[index]['label'], index)) {
      info[currentIndex]
          .add({'label': newInfo['label'], 'info': newInfo['info']});
    } else {
      info[index].add(newInfo);
    }

    notifyListeners();
  }

  // Add the whole Object of Form info
  void addInfoFinal(Info info) {
    if (!checkFinal(info.id)) {
      var currInfo = infoFinal[infoFinalIndex].info;
      Info particularForm = Info(
          dateCreated: infoFinal[infoFinalIndex].dateCreated,
          editorId: infoFinal[infoFinalIndex].editorId,
          editorNumber: infoFinal[infoFinalIndex].editorId,
          encryption: 1,
          id: infoFinal[infoFinalIndex].id,
          info: currInfo);
      particularForm.info.add(info.info);

      infoFinal[infoFinalIndex] = particularForm;
    } else {
      infoFinal.add(info);
    }
  }

  void removeInfo(int index) {
    info.removeAt(index);
    notifyListeners();
  }

  Info getFormInfo(String id) {
    Info particularForm = Info(
        dateCreated: '',
        editorId: '',
        editorNumber: '',
        encryption: 0,
        id: "",
        info: []);

    for (var element in infoFinal) {
      if (element.id == id) {
        particularForm = element;
      }
    }

    return particularForm;
  }

  bool check(String label, int index) {
    bool res = false;

    for (var i = 0; i < info[index].length; i++) {
      var map = info[index][i];
      if (map['label'] == label) {
        // If the variable is present in the map, set the variableExists variable to true.
        res = true;
        currentIndex = i;
        break;
      }
    }

    return res;
  }

  bool checkFinal(String id) {
    bool res = false;

    for (var i = 0; i < infoFinal.length; i++) {
      var map = infoFinal[i];
      if (map.id == id) {
        // If the variable is present in the map, set the variableExists variable to true.
        res = true;
        infoFinalIndex = i;
        break;
      }
    }

    return res;
  }
}
