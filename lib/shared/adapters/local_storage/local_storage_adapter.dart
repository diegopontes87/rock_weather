abstract class LocalStorageAdapter {
  Future<void> setString(String key, dynamic value);
  Future<void> setStringList(String key, List<String> value);
  Future<String> getString(String key);
  Future<List<String>> getStringList(String key);
}
