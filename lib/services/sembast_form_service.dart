import 'package:digital_data_tree/models/form_model.dart';
import 'package:digital_data_tree/models/info_model.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';

import '../repositories_abstracts/form_repository.dart';
import '../repositories_abstracts/info_repository.dart';

class SembastFormService extends FormRepository {
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("form_store");

  @override
  Future<void> insertForm(FormModel form) async {
    await _store.add(_database, form.toMap());
  }

  @override
  Future<List<dynamic>> getForms() async {
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) =>
            FormModel.fromMap(snapshot.key as int, snapshot.value as Map))
        .toList();
  }

  @override
  Future deleteForm(FormModel form) async {
    // await _store.delete(_database);
    var filter = Filter.matches('id', form.id);
    var finder = Finder(filter: filter);
    return await _store.delete(_database, finder: finder);
  }
}
