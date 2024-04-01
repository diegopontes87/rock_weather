import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rock_weather/core/domain/weather/usecases/get_forecast_by_city_usecase.dart';
import 'package:rock_weather/shared/errors/app_error.dart';

import '../../../../mocks/global_mocks.dart';
import '../../../../models/models.dart';

void main() {
  late MockWeatherRepository mockWeatherRepository;
  late GetForecastByCityUsecase getForecastByCityUsecase;

  setUp(
    () {
      mockWeatherRepository = MockWeatherRepository();
      getForecastByCityUsecase = GetForecastByCityUsecase(
        repository: mockWeatherRepository,
      );
    },
  );

  group(
    'GetForecastByCityUsecase',
    () {
      test(
        'should return CityForecast when Success',
        () async {
          final cityForecast = cityForecastModel.toEntity();
          when(
            () => mockWeatherRepository.getCityForecast(cityName: 'cityName'),
          ).thenAnswer(
            (_) async => Success(cityForecast),
          );

          final response = await getForecastByCityUsecase(cityName: 'cityName');

          final entity = response.tryGetSuccess();
          expect(entity, cityForecast);
        },
      );

      test(
        'should return AppError when Error',
        () async {
          final appError = AppError(errorType: AppErrorType.untrackedError);
          when(
            () => mockWeatherRepository.getCityForecast(cityName: 'cityName'),
          ).thenAnswer(
            (_) async => Error(appError),
          );

          final response = await getForecastByCityUsecase(cityName: 'cityName');

          final error = response.tryGetError();
          expect(error, appError);
        },
      );
    },
  );
}
