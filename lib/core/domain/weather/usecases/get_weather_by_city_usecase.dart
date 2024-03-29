import 'package:multiple_result/multiple_result.dart';
import 'package:rock_weather/core/domain/weather/entities/weather_data_entity.dart';
import 'package:rock_weather/core/domain/weather/repository/weather_repository.dart';
import 'package:rock_weather/shared/errors/app_error.dart';

class GetWeatherByCityUsecase {
  final WeatherRepository _repository;

  GetWeatherByCityUsecase({
    required WeatherRepository repository,
  }) : _repository = repository;

  Future<Result<WeatherData, AppError>> call({required String cityName}) async {
    return await _repository.getCityWeather(cityName: cityName);
  }
}
