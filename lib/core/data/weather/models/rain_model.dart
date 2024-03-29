import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rock_weather/core/domain/weather/entities/rain_entity.dart';

part 'rain_model.g.dart';

@JsonSerializable()
class RainModel {
  RainModel({
    this.d1h,
  });

  final double? d1h;

  factory RainModel.fromJson(Map<String, Object?> json) => _$RainModelFromJson(json);

  Map<String, dynamic> toJson() => _$RainModelToJson(this);

  Rain toEntity() => Rain(
        rainVolumeLastHour: d1h,
      );
}
