import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';

class UserViewModel extends ChangeNotifier {
  var user;
  int currentIndex = 0;

  void addUser(UserModel user) async {
    user = user;
    notifyListeners();
  }
}
