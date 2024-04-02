import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rock_weather/core/domain/weather/entities/weather_data_entity.dart';
import 'package:rock_weather/core/domain/weather/usecases/get_forecast_by_city_usecase.dart';
import 'package:rock_weather/core/presentation/forecast/cubit/forecast_cubit.dart';
import 'package:rock_weather/shared/errors/app_error.dart';

import '../../../../mocks/global_mocks.dart';
import '../../../../models/models.dart';

void main() {
  late ForecastCubit cubit;
  late GetForecastByCityUsecase mockGetForecastByCityUsecase;
  final mockSaoPauloWeatherData = saoPauloWeatherDataModel.toEntity();
  final mockSaoPauloForecastData = saoPaulocityForecastModel.toEntity();
  Map<DateTime, List<WeatherData>> weathersByDay = {};

  setUp(
    () {
      mockGetForecastByCityUsecase = MockGetForecastByCityUsecase();
      cubit = ForecastCubit(
        getForecastByCityUsecase: mockGetForecastByCityUsecase,
        weatherData: mockSaoPauloWeatherData,
      );
    },
  );

  void mockUsecaseSuccessRequest() {
    when(
      () => mockGetForecastByCityUsecase.call(cityName: 'São Paulo'),
    ).thenAnswer(
      (invocation) async => Success(mockSaoPauloForecastData),
    );
  }

  void mockUsecaseErrorRequest() {
    when(
      () => mockGetForecastByCityUsecase.call(cityName: any<String>(named: 'cityName')),
    ).thenAnswer(
      (_) async => Error(AppError(errorType: AppErrorType.untrackedError)),
    );
  }

  group(
    'ForecastCubit',
    () {
      group(
        'getForecastByCity',
        () {
          blocTest<ForecastCubit, ForecastState>(
            'should get ForecastCity data for a specific city',
            setUp: () {
              mockUsecaseSuccessRequest();
              weathersByDay = cubit.splitWeatherIntoLists(mockSaoPauloForecastData.forecastList ?? []);
            },
            build: () => cubit,
            act: (cubit) => cubit.getForecastByCity(),
            expect: () {
              final initialState = ForecastState.initial(weatherData: mockSaoPauloWeatherData);
              final loadingStateTrue = initialState.copyWith(isLoading: true);
              final forecastState = loadingStateTrue.copyWith(
                cityForecast: mockSaoPauloForecastData,
                weathersByDay: weathersByDay,
                isLoading: false,
              );
              return [
                loadingStateTrue,
                forecastState,
              ];
            },
          );

          blocTest<ForecastCubit, ForecastState>(
            'should get error when getForecastByCity is Error',
            setUp: () {
              mockUsecaseErrorRequest();
              weathersByDay = cubit.splitWeatherIntoLists(mockSaoPauloForecastData.forecastList ?? []);
            },
            build: () => cubit,
            act: (cubit) => cubit.getForecastByCity(),
            expect: () {
              final error = AppError(errorType: AppErrorType.untrackedError);

              final initialState = ForecastState.initial(weatherData: mockSaoPauloWeatherData);
              final loadingStateTrue = initialState.copyWith(isLoading: true);
              final errorState = loadingStateTrue.copyWith(
                isLoading: false,
                errorType: error.errorType,
                isError: true,
              );
              return [
                loadingStateTrue,
                errorState,
              ];
            },
          );
        },
      );
    },
  );
}
