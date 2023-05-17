import 'package:digital_data_tree/models/info_model.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';

import '../repositories_abstracts/info_repository.dart';

class SembastInfoService extends InfoRepository {
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("info_store");

  @override
  Future<void> insertInfo(Info info) async {
    await _store.add(_database, info.toMap());
  }

  @override
  Future<List<dynamic>> getInfo() async {
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) =>
            Info.fromMap(snapshot.key as int, snapshot.value as Map))
        .toList();
  }

  @override
  Future updateInfo(Info info) async {
    // TODO: implement updateInfo
    return await _store.record(info.id).update(_database, info.toMap());
  }

  @override
  Future deleteInfo(Info info) async {
    return await _store.record(info.id).delete(_database);
  }
}
