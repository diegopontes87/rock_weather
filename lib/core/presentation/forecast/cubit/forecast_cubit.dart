import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rock_weather/core/domain/weather/entities/city_forecast_entity.dart';
import 'package:rock_weather/core/domain/weather/entities/weather_data_entity.dart';
import 'package:rock_weather/core/domain/weather/usecases/get_forecast_by_city_usecase.dart';
import 'package:rock_weather/shared/utils/date_time_utils.dart';

part 'forecast_cubit.freezed.dart';
part 'forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  final GetForecastByCityUsecase _getForecastByCityUsecase;
  ForecastCubit({
    required GetForecastByCityUsecase getForecastByCityUsecase,
    required WeatherData weatherData,
  })  : _getForecastByCityUsecase = getForecastByCityUsecase,
        super(
          ForecastState.initial(weatherData: weatherData),
        );

  Future<void> getForecastByCity() async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    final result = await _getForecastByCityUsecase(cityName: state.weatherData.locationName!);
    result.when(
      (cityForecast) {
        final weathersByDay = splitWeatherIntoLists(cityForecast.forecastList ?? []);
        emit(
          state.copyWith(
            cityForecast: cityForecast,
            weathersByDay: weathersByDay,
            isLoading: false,
          ),
        );
      },
      (error) {
        emit(
          state.copyWith(
            isLoading: false,
          ),
        );
      },
    );
  }

  Map<DateTime, List<WeatherData>> splitWeatherIntoLists(List<WeatherData> weatherDataList) {
    Map<DateTime, List<WeatherData>> weathersByDay = {};
    for (final weather in weatherDataList) {
      final day = DateTimeUtils.getDateDay(weather.dataCalculationTime ?? 0);
      if (!DateTimeUtils.isDateToday(weather.dataCalculationTime ?? 0)) {
        weathersByDay.putIfAbsent(day, () => []).add(weather);
      }
    }

    return weathersByDay;
  }
}
