import 'package:flutter/cupertino.dart';

class SearchViewModel extends ChangeNotifier {
  String searchString = "";

  void setSearch(String search) async {
    searchString = search;
    notifyListeners();
  }
}
