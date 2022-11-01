import 'package:flutter_hive_tdo/data/data_source/_local/hive_data_store.dart';
import 'package:flutter_hive_tdo/domain/repo_interface/data_store.interface.dart';
import 'package:get_it/get_it.dart';

GetIt getit = GetIt.instance;

void initializeLocatorDependncies({required AppConfig config}) {
  getit.registerLazySingleton<HiveDataStoreInterface>(() => HiveDataStore());
}

class AppConfig {}
