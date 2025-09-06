import 'package:shared_preferences/shared_preferences.dart';

class LocalBasicDataService {
  static late final SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> save(String key, dynamic value) async {
    if (value is String) return sharedPreferences.setString(key, value);
    if (value is int) return sharedPreferences.setInt(key, value);
    if (value is bool) return sharedPreferences.setBool(key, value);
    if (value is double) return sharedPreferences.setDouble(key, value);
    if (value is List<String>) {
      return sharedPreferences.setStringList(key, value);
    }
    return false;
  }

  static T? read<T>(String key) {
    return sharedPreferences.get(key) as T?;
  }

  static bool containsKey(String key) {
    return sharedPreferences.containsKey(key);
  }

  static Future<bool> remove(String key) async {
    return await sharedPreferences.remove(key);
  }
}
