import 'package:rock_weather/core/domain/weather/entities/city_entity.dart';
import 'package:rock_weather/core/domain/weather/entities/weather_data_entity.dart';

class CityForecast {
  CityForecast({
    this.city,
    this.forecastList,
  });

  final City? city;
  final List<WeatherData>? forecastList;
}
