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
    this.coordinates,
    this.main,
    this.wind,
    this.rain,
    this.clouds,
    this.weathers,
  });
  final String? base;
  final int? visibility;
  final int? dt;
  final int? timezone;
  final int? id;
  final String? name;
  @JsonKey(name: 'coord')
  final CoordinatesModel? coordinates;
  @JsonKey(name: 'main')
  final MainModel? main;
  @JsonKey(name: 'wind')
  final WindModel? wind;
  @JsonKey(name: 'rain')
  final RainModel? rain;
  @JsonKey(name: 'clouds')
  final CloudsModel? clouds;
  @JsonKey(name: 'weather')
  final List<WeatherModel>? weathers;

  factory WeatherDataModel.fromJson(Map<String, Object?> json) => _$WeatherDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDataModelToJson(this);

  WeatherData toEntity() => WeatherData(
        base: base,
        visibility: visibility,
        dataCalculationTime: dt,
        timezone: timezone,
        id: id,
        locationName: name,
        coordinates: coordinates?.toEntity(),
        coreWeatherInfo: main?.toEntity(),
        wind: wind?.toEntity(),
        rain: rain?.toEntity(),
        clouds: clouds?.toEntity(),
        weathers: weathers?.map((weather) => weather.toEntity()).toList(),
      );
}
