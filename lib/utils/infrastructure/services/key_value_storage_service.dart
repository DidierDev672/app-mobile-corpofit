abstract class KeyValueStorageService {
  Future<void> initialize();
  Future<void> setKeyValue<T>(String key, T value);
  Future<T?> getKeyValue<T>(String key);
  Future<void> removeKey(String key);
}
