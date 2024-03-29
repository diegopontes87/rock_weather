import 'package:multiple_result/multiple_result.dart';
import 'package:rock_weather/core/data/weather/local_datasource/weather_local_datasource.dart';
import 'package:rock_weather/core/data/weather/remote_datasource/weather_remote_datasource.dart';
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
  Future<Result<WeatherData, AppError>> getCityWeather({required String cityName}) {
    throw UnimplementedError();
  }
}
