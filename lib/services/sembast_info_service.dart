import 'package:digital_data_tree/models/info_model.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';

import '../repositories_abstracts/info_repository.dart';

class SembastInfoService extends InfoRepository {
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("info_store");

  @override
  Future<void> insertInfo(Info info) async {
    var filter = Filter.matches('infoId', info.infoId);
    var finder = Finder(filter: filter);
    var snapshots = await _store.find(_database, finder: finder);
    var infoList = snapshots
        .map((snapshot) => Info.fromMap(snapshot.value as Map))
        .toList();

    if (infoList.isNotEmpty) {
      var currInfo = infoList[0].info;
      currInfo.addAll(info.info);
      Info particularForm = Info(
          title: info.title,
          descr: info.descr,
          dateCreated: infoList[0].dateCreated,
          editorId: infoList[0].editorId,
          adminId: infoList[0].adminId,
          encryption: 1,
          infoId: infoList[0].infoId,
          info: currInfo);
      await _store.update(_database, particularForm.toMap(), finder: finder);
    } else {
      await _store.add(_database, info.toMap());
    }
  }

  @override
  Future<List<dynamic>> getAllInfo() async {
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) => Info.fromMap(snapshot.value as Map))
        .toList();
  }

  @override
  Future<List<dynamic>> getInfo(String id) async {
    var filter = Filter.matches('infoId', id);
    var finder = Finder(filter: filter);
    var snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => Info.fromMap(snapshot.value as Map))
        .toList();
  }

  @override
  Future updateInfo(Info info) async {
    var filter = Filter.matches('infoId', info.infoId);
    var finder = Finder(filter: filter);
    return await _store.update(_database, info.toMap(), finder: finder);
  }

  @override
  Future deleteInfo(Info info) async {
    // return await _store.delete(_database);
    var filter = Filter.matches('infoId', info.infoId);
    var finder = Finder(filter: filter);
    return await _store.delete(_database, finder: finder);
  }
}
