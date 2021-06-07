import 'package:priyo_quiz/services/navigation/navigation_service.dart';
import 'package:priyo_quiz/services/remote_config.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => NavigationService());

  var remoteConfigService = RemoteConfigService.getInstance();
  locator.registerSingleton(remoteConfigService);
}
