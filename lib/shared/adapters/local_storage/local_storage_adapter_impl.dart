import 'package:rock_weather/shared/adapters/local_storage/local_storage_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageAdapterImpl implements LocalStorageAdapter {
  final SharedPreferences _sharedPreferences;

  LocalStorageAdapterImpl({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  @override
  Future<void> setString(String key, value) async {
    await _sharedPreferences.setString(key, value);
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    await _sharedPreferences.setStringList(key, value);
  }

  @override
  Future<String> getString(String key) async {
    return _sharedPreferences.getString(key) ?? '';
  }

  @override
  Future<List<String>> getStringList(String key) async {
    return _sharedPreferences.getStringList(key) ?? [];
  }
}
