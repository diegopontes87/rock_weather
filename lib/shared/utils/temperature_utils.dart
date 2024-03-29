abstract class TemperatureUtils {
  static String kelvinToCelsius(double kelvin) {
    return (kelvin - 273.15).round().toString();
  }
}
