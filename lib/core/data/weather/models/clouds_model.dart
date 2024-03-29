import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rock_weather/core/domain/weather/entities/clouds_entity.dart';

part 'clouds_model.g.dart';

@JsonSerializable()
class CloudsModel {
  CloudsModel({
    this.all,
  });
  final int? all;

  factory CloudsModel.fromJson(Map<String, Object?> json) => _$CloudsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CloudsModelToJson(this);

  Clouds toEntity() => Clouds(
        cloudinessPercentage: all,
      );
}
