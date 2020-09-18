import 'package:get_it/get_it.dart';
import 'package:um/Widgets/Desktop/NavBarDesktop.dart';
import 'package:um/layout_template/layout_template.dart';

import 'navigation_service.dart';

GetIt locator = GetIt.instance;
GetIt templater = GetIt.instance;
GetIt navBar = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  templater.registerLazySingleton(() => LayoutTemplate());
  // navBar.registerLazySingleton(() => NavBarDesktop());
}
