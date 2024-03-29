import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rock_weather/core/data/weather/models/city_model.dart';
import 'package:rock_weather/core/data/weather/models/weather_data_model.dart';
import 'package:rock_weather/core/domain/weather/entities/city_forecast_entity.dart';

part 'city_forecast_model.g.dart';

@JsonSerializable()
class CityForecastModel {
  CityForecastModel({
    this.list,
    this.cityModel,
  });

  final CityModel? cityModel;
  final List<WeatherDataModel>? list;

  factory CityForecastModel.fromJson(Map<String, Object?> json) => _$CityForecastModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityForecastModelToJson(this);

  CityForecast toEntity() {
    return CityForecast(
      city: cityModel?.toEntity(),
      forecastList: list?.map((weather) => weather.toEntity()).toList(),
    );
  }
}
