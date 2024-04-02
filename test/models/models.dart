import 'package:rock_weather/core/data/weather/models/city_forecast_model.dart';
import 'package:rock_weather/core/data/weather/models/weather_data_model.dart';

import '../jsons/city_forecast_json.dart';
import '../jsons/weather_data_json.dart';

//General Model
final weatherDataModel = WeatherDataModel.fromJson(weatherDataJson);
//City Named Models
final saoPauloWeatherDataModel = WeatherDataModel.fromJson(saoPauloWeatherDataJson);
final silverstoneWeatherDataModel = WeatherDataModel.fromJson(silverstoneWeatherDataJson);
final melbourneWeatherDataModel = WeatherDataModel.fromJson(melbourneWeatherDataJson);
final monteCarloWeatherDataModel = WeatherDataModel.fromJson(monteCarloWeatherDataJson);
//General Forecast Model
final cityForecastModel = CityForecastModel.fromJson(cityForecastJson);
final saoPaulocityForecastModel = CityForecastModel.fromJson(saoPaulocityForecastJson);
//Named City Model List
final mockModelList = [
  saoPauloWeatherDataModel,
  silverstoneWeatherDataModel,
  melbourneWeatherDataModel,
  monteCarloWeatherDataModel,
];
