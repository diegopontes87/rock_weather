import 'package:flutter_test/flutter_test.dart';
import 'package:rock_weather/core/data/weather/remote_datasource/request/get_city_forecast_request.dart';
import 'package:rock_weather/core/data/weather/remote_datasource/request/get_city_weather_request.dart';

class FakeGetCityWeatherRequest extends Fake implements GetCityWeatherRequest {}

class FakeGetCityForecastRequest extends Fake implements GetCityForecastRequest {}
