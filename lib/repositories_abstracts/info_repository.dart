import '../models/info_model.dart';

abstract class InfoRepository {
  Future insertInfo(Info info);

  Future updateInfo(Info info);

  Future deleteInfo(Info info);

  Future<List<dynamic>> getInfo(String id);

  Future<List<dynamic>> getAllInfo();
}
