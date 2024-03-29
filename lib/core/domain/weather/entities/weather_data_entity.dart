import 'package:rock_weather/core/domain/weather/entities/clouds_entity.dart';
import 'package:rock_weather/core/domain/weather/entities/coordinates_entity.dart';
import 'package:rock_weather/core/domain/weather/entities/core_weather_info_entity.dart';
import 'package:rock_weather/core/domain/weather/entities/rain_entity.dart';
import 'package:rock_weather/core/domain/weather/entities/weather_entity.dart';
import 'package:rock_weather/core/domain/weather/entities/wind_entity.dart';

class WeatherData {
  WeatherData({
    this.base,
    this.visibility,
    this.dataCalculationTime,
    this.timezone,
    this.id,
    this.locationName,
    this.coordinates,
    this.coreWeatherInfo,
    this.wind,
    this.rain,
    this.clouds,
    this.weathers,
  });
  final String? base;
  final int? visibility;
  final int? dataCalculationTime;
  final int? timezone;
  final int? id;
  final String? locationName;
  final Coordinates? coordinates;
  final CoreWeatherInfo? coreWeatherInfo;
  final Wind? wind;
  final Rain? rain;
  final Clouds? clouds;
  final List<WeatherInfo>? weathers;
}
