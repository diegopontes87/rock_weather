import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rock_weather/core/data/weather/repository/weather_repository_impl.dart';
import 'package:rock_weather/core/domain/weather/repository/weather_repository.dart';
import 'package:rock_weather/shared/errors/app_error.dart';

import '../../../../mocks/global_mocks.dart';
import '../../../../models/models.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late MockWeatherLocalDataSource mockWeatherLocalDataSource;
  late WeatherRepository weatherRepository;

  setUp(
    () {
      mockWeatherLocalDataSource = MockWeatherLocalDataSource();
      mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
      weatherRepository = WeatherRepositoryImpl(
        localDataSource: mockWeatherLocalDataSource,
        remoteDataSource: mockWeatherRemoteDataSource,
      );
    },
  );

  group(
    'WeatherRepositoryImpl',
    () {
      group(
        'getCityWeather',
        () {
          test(
            'should return WeatherData when getCityWeather returns Success and save user locally',
            () async {
              when(
                () => mockWeatherRemoteDataSource.getCityWeather(cityName: 'cityName'),
              ).thenAnswer(
                (_) async => Success(weatherDataModel),
              );

              when(
                () => mockWeatherLocalDataSource.saveCityWeatherLocally(
                  cityName: 'cityName',
                  weatherDataModel: weatherDataModel,
                ),
              ).thenAnswer(
                (_) async => {},
              );

              final response = await weatherRepository.getCityWeather(cityName: 'cityName');
              final entity = response.tryGetSuccess();

              expect(entity, weatherDataModel.toEntity());
              verify(
                () => mockWeatherLocalDataSource.saveCityWeatherLocally(
                  cityName: 'cityName',
                  weatherDataModel: weatherDataModel,
                ),
              ).called(1);
            },
          );

          test(
            'should return noConnection error and try return a local weatherData',
            () async {
              when(
                () => mockWeatherRemoteDataSource.getCityWeather(cityName: 'cityName'),
              ).thenAnswer(
                (_) async => Error(AppError(errorType: AppErrorType.noConnectionError)),
              );

              when(
                () => mockWeatherLocalDataSource.getCityWeatherLocally(
                  cityName: 'cityName',
                ),
              ).thenAnswer(
                (_) async => weatherDataModel,
              );

              final response = await weatherRepository.getCityWeather(cityName: 'cityName');
              final entity = response.tryGetSuccess();

              expect(entity, weatherDataModel.toEntity());
              verify(
                () => mockWeatherLocalDataSource.getCityWeatherLocally(
                  cityName: 'cityName',
                ),
              ).called(1);
            },
          );

          test(
            'should return noConnection error when weatherDataModel is null locally',
            () async {
              final connectionError = AppError(errorType: AppErrorType.noConnectionError);
              when(
                () => mockWeatherRemoteDataSource.getCityWeather(cityName: 'cityName'),
              ).thenAnswer(
                (_) async => Error(connectionError),
              );

              when(
                () => mockWeatherLocalDataSource.getCityWeatherLocally(
                  cityName: 'cityName',
                ),
              ).thenAnswer(
                (_) async => null,
              );

              final response = await weatherRepository.getCityWeather(cityName: 'cityName');
              final error = response.tryGetError();

              expect(error, connectionError);
              verify(
                () => mockWeatherLocalDataSource.getCityWeatherLocally(
                  cityName: 'cityName',
                ),
              ).called(1);
            },
          );

          test(
            'should return error when getCityWeather throws exception',
            () async {
              final serverError = AppError(errorType: AppErrorType.serviceError);
              when(
                () => mockWeatherRemoteDataSource.getCityWeather(cityName: 'cityName'),
              ).thenAnswer(
                (_) async => Error(serverError),
              );

              final response = await weatherRepository.getCityWeather(cityName: 'cityName');
              final error = response.tryGetError();

              expect(error, serverError);
            },
          );
        },
      );

      group(
        'getCityForecast',
        () {
          test(
            'should return CityForecast when getCityForecast returns Success and save user locally',
            () async {
              when(
                () => mockWeatherRemoteDataSource.getCityForecast(cityName: 'cityName'),
              ).thenAnswer(
                (_) async => Success(cityForecastModel),
              );

              when(
                () => mockWeatherLocalDataSource.saveCityForecastLocally(
                  cityName: 'cityName',
                  cityForecastModel: cityForecastModel,
                ),
              ).thenAnswer(
                (_) async => {},
              );

              final response = await weatherRepository.getCityForecast(cityName: 'cityName');
              final entity = response.tryGetSuccess();

              expect(entity, cityForecastModel.toEntity());
              verify(
                () => mockWeatherLocalDataSource.saveCityForecastLocally(
                  cityName: 'cityName',
                  cityForecastModel: cityForecastModel,
                ),
              ).called(1);
            },
          );

          test(
            'should return noConnection error and try return a local cityForecast',
            () async {
              when(
                () => mockWeatherRemoteDataSource.getCityForecast(cityName: 'cityName'),
              ).thenAnswer(
                (_) async => Error(AppError(errorType: AppErrorType.noConnectionError)),
              );

              when(
                () => mockWeatherLocalDataSource.getCityForecastLocally(
                  cityName: 'cityName',
                ),
              ).thenAnswer(
                (_) async => cityForecastModel,
              );

              final response = await weatherRepository.getCityForecast(cityName: 'cityName');
              final entity = response.tryGetSuccess();

              expect(entity, cityForecastModel.toEntity());
              verify(
                () => mockWeatherLocalDataSource.getCityForecastLocally(
                  cityName: 'cityName',
                ),
              ).called(1);
            },
          );

          test(
            'should return noConnection error when cityForecastModel is null locally',
            () async {
              final connectionError = AppError(errorType: AppErrorType.noConnectionError);
              when(
                () => mockWeatherRemoteDataSource.getCityForecast(cityName: 'cityName'),
              ).thenAnswer(
                (_) async => Error(connectionError),
              );

              when(
                () => mockWeatherLocalDataSource.getCityForecastLocally(
                  cityName: 'cityName',
                ),
              ).thenAnswer(
                (_) async => null,
              );

              final response = await weatherRepository.getCityForecast(cityName: 'cityName');
              final error = response.tryGetError();

              expect(error, connectionError);
              verify(
                () => mockWeatherLocalDataSource.getCityForecastLocally(
                  cityName: 'cityName',
                ),
              ).called(1);
            },
          );

          test(
            'should return error when getCityForecast throws exception',
            () async {
              final serverError = AppError(errorType: AppErrorType.serviceError);
              when(
                () => mockWeatherRemoteDataSource.getCityForecast(cityName: 'cityName'),
              ).thenAnswer(
                (_) async => Error(serverError),
              );

              final response = await weatherRepository.getCityForecast(cityName: 'cityName');
              final error = response.tryGetError();

              expect(error, serverError);
            },
          );
        },
      );
    },
  );
}
