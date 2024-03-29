import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rock_weather/core/domain/weather/entities/weather_data_entity.dart';
import 'package:rock_weather/core/domain/weather/usecases/get_weather_by_city_usecase.dart';
import 'package:rock_weather/shared/errors/app_error.dart';
import 'package:rock_weather/shared/res/app_texts.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetWeatherByCityUsecase _getWeatherByCityUsecase;

  HomeCubit({
    required GetWeatherByCityUsecase getWeatherByCityUsecase,
  })  : _getWeatherByCityUsecase = getWeatherByCityUsecase,
        super(
          HomeState.initial(),
        );

  Future<void> getWeatherForCities() async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    final cities = state.cityNames;
    await Future.forEach(
      cities,
      (city) async {
        final result = await _getWeatherByCityUsecase(cityName: city);
        _handleWeatherResponse(result);
      },
    );
    emit(
      state.copyWith(
        isLoading: false,
      ),
    );
  }

  void _handleWeatherResponse(Result<WeatherData, AppError> result) {
    result.when((weatherData) {
      final weatherList = <WeatherData>[];
      weatherList
        ..addAll(state.citiesWeather)
        ..add(weatherData);

      emit(
        state.copyWith(
          citiesWeather: weatherList,
        ),
      );
    }, (error) {});
  }
}
