import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rock_weather/core/domain/weather/entities/weather_entity.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel extends Equatable {
  const WeatherModel({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  factory WeatherModel.fromJson(Map<String, Object?> json) => _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  WeatherInfo toEntity() => WeatherInfo(
        id: id,
        status: main,
        description: description,
        icon: icon,
      );

  @override
  List<Object?> get props => [
        icon,
        description,
      ];
}
