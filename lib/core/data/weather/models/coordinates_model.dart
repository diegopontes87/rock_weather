import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rock_weather/core/domain/weather/entities/coordinates_entity.dart';

part 'coordinates_model.g.dart';

@JsonSerializable()
class CoordinatesModel {
  CoordinatesModel({
    this.lon,
    this.lat,
  });

  final double? lon;
  final double? lat;

  factory CoordinatesModel.fromJson(Map<String, Object?> json) => _$CoordinatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesModelToJson(this);

  Coordinates toEntity() => Coordinates(
        latitude: lat,
        longitude: lon,
      );
}
