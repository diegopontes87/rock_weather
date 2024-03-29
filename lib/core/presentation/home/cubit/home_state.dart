part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required List<String> cityNames,
    required bool isLoading,
    required bool isError,
    required List<WeatherData> citiesWeather,
  }) = _HomeState;

  factory HomeState.initial() => const HomeState(
        cityNames: AppTexts.trackedCities,
        isLoading: false,
        isError: false,
        citiesWeather: [],
      );
}
