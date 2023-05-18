import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';

class UserViewModel extends ChangeNotifier {
  late UserModel user;
  int currentIndex = 0;

  void addUser(UserModel user) {
    user = user;

    notifyListeners();
  }
}
