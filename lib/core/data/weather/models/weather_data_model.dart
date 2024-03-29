import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rock_weather/core/data/weather/models/clouds_model.dart';
import 'package:rock_weather/core/data/weather/models/coordinates_model.dart';
import 'package:rock_weather/core/data/weather/models/main_model.dart';
import 'package:rock_weather/core/data/weather/models/rain_model.dart';
import 'package:rock_weather/core/data/weather/models/weather_model.dart';
import 'package:rock_weather/core/data/weather/models/wind_model.dart';
import 'package:rock_weather/core/domain/weather/entities/weather_data_entity.dart';

part 'weather_data_model.g.dart';

@JsonSerializable()
class WeatherDataModel {
  WeatherDataModel({
    this.base,
    this.visibility,
    this.dt,
    this.timezone,
    this.id,
    this.name,
    this.coord,
    this.main,
    this.wind,
    this.rain,
    this.clouds,
    this.weather,
  });
  final String? base;
  final int? visibility;
  final int? dt;
  final int? timezone;
  final int? id;
  final String? name;
  final CoordinatesModel? coord;
  final MainModel? main;
  final WindModel? wind;
  final RainModel? rain;
  final CloudsModel? clouds;
  final List<WeatherModel>? weather;

  factory WeatherDataModel.fromJson(Map<String, Object?> json) => _$WeatherDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDataModelToJson(this);

  WeatherData toEntity() => WeatherData(
        base: base,
        visibility: visibility,
        dataCalculationTime: dt,
        timezone: timezone,
        id: id,
        locationName: name,
        coordinates: coord?.toEntity(),
        coreWeatherInfo: main?.toEntity(),
        wind: wind?.toEntity(),
        rain: rain?.toEntity(),
        clouds: clouds?.toEntity(),
        weathers: weather?.map((weather) => weather.toEntity()).toList(),
      );
}
