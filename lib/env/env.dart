abstract class Env {
  static String get appUrl => const String.fromEnvironment('baseUrl');
  static String get weatherApiKey => const String.fromEnvironment('weatherApiKey');
}
