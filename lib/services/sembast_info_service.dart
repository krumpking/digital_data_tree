import 'package:digital_data_tree/models/info_model.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';

import '../repositories_abstracts/info_repository.dart';

class SembastInfoService extends InfoRepository {
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("info_store");

  @override
  Future<void> insertInfo(Info info) async {
    var filter = Filter.matches('id', info.id);
    var finder = Finder(filter: filter);
    var snapshots = await _store.find(_database, finder: finder);
    var infoList = snapshots
        .map((snapshot) =>
            Info.fromMap(snapshot.key as int, snapshot.value as Map))
        .toList();
    if (infoList.isNotEmpty) {
      var currInfo = infoList[0].info;
      Info particularForm = Info(
          dateCreated: infoList[0].dateCreated,
          editorId: infoList[0].editorId,
          editorNumber: infoList[0].editorNumber,
          encryption: 1,
          id: infoList[0].id,
          info: currInfo);
      particularForm.info.add(info.info);
      await _store.record(infoList[0].id).update(_database, info.toMap());
    } else {
      await _store.add(_database, info.toMap());
    }
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
    return await _store.record(info.id).update(_database, info.toMap());
  }

  @override
  Future deleteInfo(Info info) async {
    return await _store.record(info.id).delete(_database);
  }
}
