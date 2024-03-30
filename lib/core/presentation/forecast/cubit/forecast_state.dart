part of 'forecast_cubit.dart';

@freezed
class ForecastState with _$ForecastState {
  const factory ForecastState({
    required WeatherData weatherData,
    required bool isLoading,
    required bool isError,
    required CityForecast? cityForecast,
    required Map<DateTime, List<WeatherData>> weathersByDay,
  }) = _ForecastState;

  factory ForecastState.initial({
    required WeatherData weatherData,
  }) =>
      ForecastState(
        weatherData: weatherData,
        isLoading: false,
        isError: false,
        cityForecast: null,
        weathersByDay: {},
      );
}
