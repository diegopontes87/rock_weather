import 'package:equatable/equatable.dart';
import 'package:rock_weather/core/domain/weather/entities/city_entity.dart';
import 'package:rock_weather/core/domain/weather/entities/weather_data_entity.dart';

class CityForecast extends Equatable {
  const CityForecast({
    this.city,
    this.forecastList,
  });

  final City? city;
  final List<WeatherData>? forecastList;

  @override
  List<Object?> get props => [
        city,
        forecastList,
      ];
}
