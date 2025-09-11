import 'package:corpofit_mobile/utils/infrastructure/services/key_value_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStorageServiceImpl extends KeyValueStorageService {
  late SharedPreferences _prefs;
  bool _isInitialized = false;

  @override
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      _prefs = await SharedPreferences.getInstance();
      _isInitialized = true;
    } catch (e) {
      throw Exception('Failed to initialize storage: $e');
    }
  }

  @override
  Future<T?> getKeyValue<T>(String key) async {
    if (!_isInitialized) await initialize();

    try {
      if (T == String) return _prefs.getString(key) as T;
      if (T == int) return _prefs.getInt(key) as T?;
      if (T == bool) return _prefs.getBool(key) as T?;
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> removeKey(String key) async {
    if (!_isInitialized) await initialize();

    await _prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    if (!_isInitialized) await initialize();

    try {
      if (value is String) {
        await _prefs.setString(key, value);
      } else if (value is int) {
        await _prefs.setInt(key, value);
      } else if (value is bool) {
        await _prefs.setBool(key, value);
      }
    } catch (e) {
      throw Exception('Failed to set value: $e');
    }
  }
}
