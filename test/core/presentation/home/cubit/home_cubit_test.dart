import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rock_weather/core/domain/weather/usecases/get_weather_by_city_usecase.dart';
import 'package:rock_weather/core/presentation/home/cubit/home_cubit.dart';
import 'package:rock_weather/shared/errors/app_error.dart';

import '../../../../mocks/global_mocks.dart';
import '../../../../models/models.dart';

void main() {
  late HomeCubit homeCubit;
  late GetWeatherByCityUsecase mockGetWeatherByCityUsecase;
  final silverstoneWeatherData = silverstoneWeatherDataModel.toEntity();
  final saoPauloWeatherData = saoPauloWeatherDataModel.toEntity();
  final melbourneWeatherData = melbourneWeatherDataModel.toEntity();
  final monteCarloWeatherData = monteCarloWeatherDataModel.toEntity();

  setUp(
    () {
      mockGetWeatherByCityUsecase = MockGetWeatherByCityUsecase();
      homeCubit = HomeCubit(getWeatherByCityUsecase: mockGetWeatherByCityUsecase);
    },
  );

  void mockUsecaseSuccessRequest() {
    when(
      () => mockGetWeatherByCityUsecase.call(cityName: 'São Paulo'),
    ).thenAnswer(
      (_) async => Success(saoPauloWeatherDataModel.toEntity()),
    );

    when(
      () => mockGetWeatherByCityUsecase.call(cityName: 'Melbourne'),
    ).thenAnswer(
      (_) async => Success(melbourneWeatherDataModel.toEntity()),
    );

    when(
      () => mockGetWeatherByCityUsecase.call(cityName: 'Monte Carlo'),
    ).thenAnswer(
      (_) async => Success(monteCarloWeatherDataModel.toEntity()),
    );

    when(
      () => mockGetWeatherByCityUsecase.call(cityName: 'Silverstone'),
    ).thenAnswer(
      (_) async => Success(silverstoneWeatherDataModel.toEntity()),
    );
  }

  void mockUsecaseErrorRequest() {
    when(
      () => mockGetWeatherByCityUsecase.call(cityName: any<String>(named: 'cityName')),
    ).thenAnswer(
      (_) async => Error(AppError(errorType: AppErrorType.untrackedError)),
    );
  }

  group(
    'HomeCubit',
    () {
      test(
        'should have HomeState.initial as state',
        () {
          expect(homeCubit.state, HomeState.initial());
        },
      );

      group(
        'getWeatherForCities',
        () {
          blocTest<HomeCubit, HomeState>(
            'should get weather when getWeatherForCities is Success',
            setUp: () {
              mockUsecaseSuccessRequest();
            },
            build: () => homeCubit,
            act: (cubit) => cubit.getWeatherForCities(),
            expect: () {
              final initialState = HomeState.initial();
              final loadingStateTrue = initialState.copyWith(isLoading: true);
              final firstCityWeatherState = loadingStateTrue.copyWith(citiesWeather: [
                silverstoneWeatherData,
              ]);
              final secondCityWeatherState = firstCityWeatherState.copyWith(citiesWeather: [
                silverstoneWeatherData,
                saoPauloWeatherData,
              ]);
              final thirdCityWeatherState = secondCityWeatherState.copyWith(citiesWeather: [
                silverstoneWeatherData,
                saoPauloWeatherData,
                melbourneWeatherData,
              ]);
              final fourthCityWeatherState = thirdCityWeatherState.copyWith(citiesWeather: [
                silverstoneWeatherData,
                saoPauloWeatherData,
                melbourneWeatherData,
                monteCarloWeatherData,
              ]);
              final loadingStateFalse = fourthCityWeatherState.copyWith(isLoading: false);

              return [
                loadingStateTrue,
                firstCityWeatherState,
                secondCityWeatherState,
                thirdCityWeatherState,
                fourthCityWeatherState,
                loadingStateFalse,
              ];
            },
          );

          blocTest<HomeCubit, HomeState>(
            'should get error when getWeatherForCities is Error',
            setUp: () {
              mockUsecaseErrorRequest();
            },
            build: () => homeCubit,
            act: (cubit) => cubit.getWeatherForCities(),
            verify: (cubit) {
              verify(() => mockGetWeatherByCityUsecase.call(cityName: any(named: 'cityName'))).called(4);
            },
            expect: () {
              final error = AppError(errorType: AppErrorType.untrackedError);
              final initialState = HomeState.initial();
              final loadingStateTrue = initialState.copyWith(isLoading: true);
              final errorState = loadingStateTrue.copyWith(errorType: error.errorType, isError: true);
              final loadingStateFalse = errorState.copyWith(isLoading: false);

              return [
                loadingStateTrue,
                errorState,
                loadingStateFalse,
              ];
            },
          );
        },
      );

      group(
        'searchCity',
        () {
          blocTest<HomeCubit, HomeState>(
            'should emit city list with city name if searched',
            setUp: () {
              mockUsecaseSuccessRequest();
            },
            build: () => homeCubit,
            act: (cubit) async {
              await cubit.getWeatherForCities();
              cubit.searchCity('São Paulo');
            },
            expect: () {
              final weatherData = saoPauloWeatherDataModel.toEntity();
              final initialState = HomeState.initial();
              final loadingStateTrue = initialState.copyWith(isLoading: true);
              final firstCityWeatherState = loadingStateTrue.copyWith(citiesWeather: [
                silverstoneWeatherData,
              ]);
              final secondCityWeatherState = firstCityWeatherState.copyWith(citiesWeather: [
                silverstoneWeatherData,
                saoPauloWeatherData,
              ]);
              final thirdCityWeatherState = secondCityWeatherState.copyWith(citiesWeather: [
                silverstoneWeatherData,
                saoPauloWeatherData,
                melbourneWeatherData,
              ]);
              final fourthCityWeatherState = thirdCityWeatherState.copyWith(citiesWeather: [
                silverstoneWeatherData,
                saoPauloWeatherData,
                melbourneWeatherData,
                monteCarloWeatherData,
              ]);
              final loadingStateFalse = fourthCityWeatherState.copyWith(isLoading: false);
              final searchedState = loadingStateFalse.copyWith(searchedCities: [weatherData]);

              return [
                loadingStateTrue,
                firstCityWeatherState,
                secondCityWeatherState,
                thirdCityWeatherState,
                fourthCityWeatherState,
                loadingStateFalse,
                searchedState,
              ];
            },
          );

          blocTest<HomeCubit, HomeState>(
            'should emit an empty list if city name is not found',
            setUp: () {
              mockUsecaseSuccessRequest();
            },
            build: () => homeCubit,
            act: (cubit) async {
              await cubit.getWeatherForCities();
              cubit.searchCity('Rio de Janeiro');
            },
            expect: () {
              final initialState = HomeState.initial();
              final loadingStateTrue = initialState.copyWith(isLoading: true);
              final firstCityWeatherState = loadingStateTrue.copyWith(citiesWeather: [
                silverstoneWeatherData,
              ]);
              final secondCityWeatherState = firstCityWeatherState.copyWith(citiesWeather: [
                silverstoneWeatherData,
                saoPauloWeatherData,
              ]);
              final thirdCityWeatherState = secondCityWeatherState.copyWith(citiesWeather: [
                silverstoneWeatherData,
                saoPauloWeatherData,
                melbourneWeatherData,
              ]);
              final fourthCityWeatherState = thirdCityWeatherState.copyWith(citiesWeather: [
                silverstoneWeatherData,
                saoPauloWeatherData,
                melbourneWeatherData,
                monteCarloWeatherData,
              ]);
              final loadingStateFalse = fourthCityWeatherState.copyWith(isLoading: false);

              return [
                loadingStateTrue,
                firstCityWeatherState,
                secondCityWeatherState,
                thirdCityWeatherState,
                fourthCityWeatherState,
                loadingStateFalse,
              ];
            },
          );
        },
      );
    },
  );
}
