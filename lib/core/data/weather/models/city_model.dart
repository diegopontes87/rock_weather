import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rock_weather/core/domain/weather/entities/city_entity.dart';

part 'city_model.g.dart';

@JsonSerializable()
class CityModel {
  CityModel({
    this.id,
    this.name,
  });
  final int? id;
  final String? name;

  factory CityModel.fromJson(Map<String, Object?> json) => _$CityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityModelToJson(this);

  City toEntity() {
    return City(
      id: id,
      name: name,
    );
  }
}
