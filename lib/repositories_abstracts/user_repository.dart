import '../models/user_model.dart';

abstract class UserRepository {
  void insertUser(UserModel user);

  Future updateUser(UserModel user);

  Future deleteUser(UserModel user);

  Future<List<UserModel>> getUser();
}
