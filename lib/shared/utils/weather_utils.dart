abstract class WeatherUtils {
  static String kelvinToCelsius(double kelvin) {
    return (kelvin - 273.15).round().toString();
  }

  static String metersPerSecondToKilometersPerHour(double metersPerSecond) {
    return '${(metersPerSecond * 3.6).round()}km/h';
  }
}
