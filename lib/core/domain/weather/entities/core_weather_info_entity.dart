import 'package:equatable/equatable.dart';

class CoreWeatherInfo extends Equatable {
  const CoreWeatherInfo({
    this.temp,
    this.tempSensation,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.pressureSeaLevel,
    this.pressureGroundLevel,
  });

  final int? temp;
  final double? tempSensation;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? humidity;
  final int? pressureSeaLevel;
  final int? pressureGroundLevel;

  @override
  List<Object?> get props => [
        temp,
        tempSensation,
        tempMin,
        tempMax,
        pressure,
        humidity,
        pressureSeaLevel,
        pressureGroundLevel,
      ];
}
