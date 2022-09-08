// Registration of services
import 'package:get_it/get_it.dart';

import '../../network/services/database_service.dart';
import '../../network/services/navigation_service.dart';

void registerServices() {
  GetIt.instance.registerSingleton<NavigationService>(NavigationService());

  // GetIt.instance.registerSingleton<MediaService>(MediaService());

  // GetIt.instance.registerSingleton<CloudStorageService>(CloudStorageService());
  GetIt.instance.registerSingleton<DatabaseService>(DatabaseService());
}
