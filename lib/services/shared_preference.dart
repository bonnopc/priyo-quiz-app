import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  static final SharedPreferenceManager _singleton = new SharedPreferenceManager._internal();

  SharedPreferenceManager._internal();

  static SharedPreferenceManager get instance => _singleton;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  create() {
    this._prefs = SharedPreferences.getInstance();
  }

  void setInt(String key, int value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt(key, value);
  }

  Future<int> getInt(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt(key) ?? 0;
  }

  void setBool(String key, bool value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(key, value);
  }

  Future<bool> getBool(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(key) ?? false;
  }

  void setString(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(key, value);
  }

  Future<String> getString(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key) ?? "";
  }

  Future<bool> contains(String key) async {
    final SharedPreferences prefs = await _prefs;
    if (!prefs.containsKey(key)) {
      return false;
    }
    return true;
  }

  void clear() async {
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
  }

  void remove(String key) async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove(key);
  }
}
