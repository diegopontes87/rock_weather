import 'dart:developer';

import 'package:multiple_result/multiple_result.dart';
import 'package:rock_weather/core/data/weather/models/weather_data_model.dart';
import 'package:rock_weather/core/data/weather/remote_datasource/request/get_city_weather_request.dart';
import 'package:rock_weather/core/domain/weather/entities/weather_data_entity.dart';
import 'package:rock_weather/env/env.dart';
import 'package:rock_weather/shared/errors/app_error.dart';
import 'package:rock_weather/shared/http/http_client.dart';

class WeatherRemoteDataSource {
  final HttpClient _client;

  WeatherRemoteDataSource({
    required HttpClient client,
  }) : _client = client;

  Future<Result<WeatherData, AppError>> getCityWeather({required String cityName}) async {
    log('WeatherRemoteDataSource - Getting weather for $cityName');
    try {
      final response = await _client.request(
        GetCityWeatherRequest(
          data: {
            'city_name': cityName,
            'apiKey': Env.weatherApiKey,
          },
        ),
      );
      final model = WeatherDataModel.fromJson(response);
      return Success(model.toEntity());
    } on AppError catch (e, st) {
      log('WeatherRemoteDataSource - Error while trying getting the weather for the city $cityName: $st');
      return Error(e);
    }
  }
}
