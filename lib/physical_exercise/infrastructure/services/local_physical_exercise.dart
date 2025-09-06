import 'package:shared_preferences/shared_preferences.dart';

class LocalPhysicalExercise {
  static late final SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> save(String key, dynamic value) async {
    if (value is String) return _prefs.setString(key, value);
    if (value is int) return _prefs.setInt(key, value);
    if (value is double) return _prefs.setDouble(key, value);
    if (value is bool) return _prefs.setBool(key, value);
    if (value is List<String>) return _prefs.setStringList(key, value);
    return false;
  }

  static T? read<T>(String key) {
    final value = _prefs.get(key);
    if (value is T) return value;
    return null;
  }

  static bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  static Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }
}
