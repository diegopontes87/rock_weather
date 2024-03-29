import 'package:multiple_result/multiple_result.dart';
import 'package:rock_weather/core/domain/weather/entities/city_forecast_entity.dart';
import 'package:rock_weather/core/domain/weather/repository/weather_repository.dart';
import 'package:rock_weather/shared/errors/app_error.dart';

class GetForecastByCityUsecase {
  final WeatherRepository _repository;

  GetForecastByCityUsecase({
    required WeatherRepository repository,
  }) : _repository = repository;

  Future<Result<CityForecast, AppError>> call({required String cityName}) async {
    return await _repository.getCityForecast(cityName: cityName);
  }
}
