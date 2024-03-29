import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rock_weather/core/domain/weather/entities/wind_entity.dart';

part 'wind_model.g.dart';

@JsonSerializable()
class WindModel {
  WindModel({
    this.speed,
    this.deg,
    this.gust,
  });

  final double? speed;
  final int? deg;
  final double? gust;

  factory WindModel.fromJson(Map<String, Object?> json) => _$WindModelFromJson(json);

  Map<String, dynamic> toJson() => _$WindModelToJson(this);

  Wind toEntity() => Wind(
        speed: speed,
        gust: gust,
        windDirectionDegrees: deg,
      );
}
