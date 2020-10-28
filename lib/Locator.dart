import 'package:get_it/get_it.dart';
import 'package:mun_care_app/services/NavigationService.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}