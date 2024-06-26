import 'package:multiple_result/multiple_result.dart';
import 'package:rock_weather/core/data/weather/local_datasource/weather_local_datasource.dart';
import 'package:rock_weather/core/data/weather/remote_datasource/weather_remote_datasource.dart';
import 'package:rock_weather/core/domain/weather/entities/city_forecast_entity.dart';
import 'package:rock_weather/core/domain/weather/entities/weather_data_entity.dart';
import 'package:rock_weather/core/domain/weather/repository/weather_repository.dart';
import 'package:rock_weather/shared/errors/app_error.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherLocalDataSource _localDataSource;
  final WeatherRemoteDataSource _remoteDataSource;

  WeatherRepositoryImpl({
    required WeatherLocalDataSource localDataSource,
    required WeatherRemoteDataSource remoteDataSource,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  @override
  Future<Result<WeatherData, AppError>> getCityWeather({required String cityName}) async {
    final response = await _remoteDataSource.getCityWeather(cityName: cityName);

    if (response.isError() && response.tryGetError()?.errorType == AppErrorType.noConnectionError) {
      final localCityWeather = await _localDataSource.getCityWeatherLocally(cityName: cityName);
      if (localCityWeather != null) {
        return Success(localCityWeather.toEntity());
      }
    }

    if (response.isSuccess() && response.tryGetSuccess() != null) {
      final weatherDataModel = response.tryGetSuccess()!;
      _localDataSource.saveCityWeatherLocally(cityName: cityName, weatherDataModel: weatherDataModel);
    }

    return response.when((weatherDataModel) {
      return Success(weatherDataModel.toEntity());
    }, (error) {
      return Error(error);
    });
  }

  @override
  Future<Result<CityForecast, AppError>> getCityForecast({required String cityName}) async {
    final response = await _remoteDataSource.getCityForecast(cityName: cityName);

    if (response.isError() && response.tryGetError()?.errorType == AppErrorType.noConnectionError) {
      final localCityForecast = await _localDataSource.getCityForecastLocally(cityName: cityName);
      if (localCityForecast != null) {
        return Success(localCityForecast.toEntity());
      }
    }

    if (response.isSuccess() && response.tryGetSuccess() != null) {
      final cityForecastModel = response.tryGetSuccess()!;
      _localDataSource.saveCityForecastLocally(cityName: cityName, cityForecastModel: cityForecastModel);
    }

    return response.when((cityForecastModel) {
      return Success(cityForecastModel.toEntity());
    }, (error) {
      return Error(error);
    });
  }
}
