abstract class WeatherUtils {
  static String metersPerSecondToKilometersPerHour(double metersPerSecond) {
    return '${(metersPerSecond * 3.6).round()}km/h';
  }
}
