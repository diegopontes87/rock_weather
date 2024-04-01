import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rock_weather/core/domain/weather/usecases/get_weather_by_city_usecase.dart';
import 'package:rock_weather/shared/errors/app_error.dart';

import '../../../../mocks/global_mocks.dart';
import '../../../../models/models.dart';

void main() {
  late MockWeatherRepository mockWeatherRepository;
  late GetWeatherByCityUsecase getWeatherByCityUsecase;

  setUp(
    () {
      mockWeatherRepository = MockWeatherRepository();
      getWeatherByCityUsecase = GetWeatherByCityUsecase(
        repository: mockWeatherRepository,
      );
    },
  );

  group(
    'GetWeatherByCityUsecase',
    () {
      test(
        'should return WeatherData when Success',
        () async {
          final weatherData = weatherDataModel.toEntity();
          when(
            () => mockWeatherRepository.getCityWeather(cityName: 'cityName'),
          ).thenAnswer(
            (_) async => Success(weatherData),
          );

          final response = await getWeatherByCityUsecase(cityName: 'cityName');

          final entity = response.tryGetSuccess();
          expect(entity, weatherData);
        },
      );

      test(
        'should return AppError when Error',
        () async {
          final appError = AppError(errorType: AppErrorType.untrackedError);
          when(
            () => mockWeatherRepository.getCityWeather(cityName: 'cityName'),
          ).thenAnswer(
            (_) async => Error(appError),
          );

          final response = await getWeatherByCityUsecase(cityName: 'cityName');

          final error = response.tryGetError();
          expect(error, appError);
        },
      );
    },
  );
}
