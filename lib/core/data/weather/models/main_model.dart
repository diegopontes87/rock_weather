import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rock_weather/core/domain/weather/entities/core_weather_info_entity.dart';

part 'main_model.g.dart';

@JsonSerializable()
class MainModel {
  MainModel({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? humidity;
  final int? seaLevel;
  final int? grndLevel;

  factory MainModel.fromJson(Map<String, Object?> json) => _$MainModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainModelToJson(this);

  CoreWeatherInfo toEntity() => CoreWeatherInfo(
        temp: temp,
        tempSensation: feelsLike,
        tempMin: tempMin,
        tempMax: tempMax,
        pressure: pressure,
        humidity: humidity,
        pressureGroundLevel: seaLevel,
        pressureSeaLevel: grndLevel,
      );
}
