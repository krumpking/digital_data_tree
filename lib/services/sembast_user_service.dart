import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';

import '../models/user_model.dart';
import '../repositories_abstracts/user_repository.dart';

class SembastUserService extends UserRepository {
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("user_store");

  @override
  Future<void> insertUser(UserModel user) async {
    await _store.add(_database, user.toMap());
  }

  @override
  Future<List<UserModel>> getUser() async {
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) =>
            UserModel.fromMap(snapshot.key as int, snapshot.value as Map))
        .toList();
  }

  @override
  Future deleteUser(UserModel user) async {
    return await _store.record(user.id).delete(_database);
  }

  @override
  Future updateUser(UserModel user) async {
    return await _store.record(user.id).update(_database, user.toMap());
  }
}
