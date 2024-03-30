class CoreWeatherInfo {
  CoreWeatherInfo({
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
}
