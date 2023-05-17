import '../models/info_model.dart';

abstract class InfoRepository {
  void insertInfo(Info info);

  Future updateInfo(Info info);

  Future deleteInfo(Info info);

  Future<List<dynamic>> getInfo();
}
