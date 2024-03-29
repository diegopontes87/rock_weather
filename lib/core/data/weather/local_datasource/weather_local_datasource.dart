import 'dart:convert';

import 'package:rock_weather/core/data/weather/models/weather_data_model.dart';
import 'package:rock_weather/core/domain/weather/entities/weather_data_entity.dart';
import 'package:rock_weather/shared/adapters/local_storage/local_storage_adapter.dart';

class WeatherLocalDataSource {
  final LocalStorageAdapter _localStorageAdapter;

  WeatherLocalDataSource({
    required LocalStorageAdapter localStorageAdapter,
  }) : _localStorageAdapter = localStorageAdapter;

  Future<void> saveCityWeatherLocally({
    required String cityName,
    required WeatherDataModel weatherDataModel,
  }) async {
    final json = weatherDataModel.toJson();
    await _localStorageAdapter.setString(cityName, jsonEncode(json));
  }

  Future<WeatherData> getCityWeatherLocally({required String cityName}) async {
    final jsonString = await _localStorageAdapter.getString(cityName);
    final jsonDecoded = jsonDecode(jsonString);
    final weatherDataModel = WeatherDataModel.fromJson(jsonDecoded);
    return weatherDataModel.toEntity();
  }
}
