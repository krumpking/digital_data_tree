import 'package:digital_data_tree/services/sembast_info_service.dart';
import 'package:digital_data_tree/services/sembast_user_service.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../repositories_abstracts/form_repository.dart';
import '../repositories_abstracts/info_repository.dart';
import '../repositories_abstracts/user_repository.dart';
import '../services/sembast_form_service.dart';

class Init {
  static Future initialize() async {
    await _initSembast();
    _registerRepositories();
  }

  static Future _initSembast() async {
    final appDir = await getApplicationDocumentsDirectory();
    await appDir.create(recursive: true);
    final databasePath = join(appDir.path, "sembast.db");
    final database = await databaseFactoryIo.openDatabase(databasePath);
    GetIt.I.registerSingleton<Database>(database);
  }

  static _registerRepositories() {
    GetIt.I.registerLazySingleton<InfoRepository>(() => SembastInfoService());
    GetIt.I.registerLazySingleton<UserRepository>(() => SembastUserService());
    GetIt.I.registerLazySingleton<FormRepository>(() => SembastFormService());
  }
}
