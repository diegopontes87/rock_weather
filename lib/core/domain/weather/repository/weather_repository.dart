import 'package:multiple_result/multiple_result.dart';
import 'package:rock_weather/core/domain/weather/entities/city_forecast_entity.dart';
import 'package:rock_weather/core/domain/weather/entities/weather_data_entity.dart';
import 'package:rock_weather/shared/errors/app_error.dart';

abstract class WeatherRepository {
  Future<Result<WeatherData, AppError>> getCityWeather({required String cityName});
  Future<Result<CityForecast, AppError>> getCityForecast({required String cityName});
}
