import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:priyo_quiz/constants/remote_config_keys.dart';

class RemoteConfigService {
  final RemoteConfig _remoteConfig;
  final defaults = <String, dynamic>{
    RemoteConfigKeys.APP_CONFIG: "",
    RemoteConfigKeys.MINIMUM_ALLOWED_VERSION: ""
  };


  static RemoteConfigService getInstance() {
    return RemoteConfigService(RemoteConfig.instance);
  }

  RemoteConfigService(RemoteConfig remoteConfig)
      : _remoteConfig = remoteConfig;

  String get appConfig => _remoteConfig.getString(RemoteConfigKeys.APP_CONFIG);

  String get minimumAllowedVersion =>
      _remoteConfig.getString(RemoteConfigKeys.MINIMUM_ALLOWED_VERSION);

  Future initialise() async {
    print('[CONFIG] trying to get configs');
    try {
      await _remoteConfig.setDefaults(defaults);
      await _fetchAndActivate();
      print('Remote config fetched and activated');
    } catch (e) {
      print(
          'Unable to fetch remote config. Cached or default values will be used');
    }
  }

  Future _fetchAndActivate() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 10),
      minimumFetchInterval: Duration(hours: 1),
    ));
    await _remoteConfig.fetchAndActivate();
  }
}
