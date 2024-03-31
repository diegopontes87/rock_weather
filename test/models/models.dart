import 'package:rock_weather/core/data/weather/models/city_forecast_model.dart';
import 'package:rock_weather/core/data/weather/models/weather_data_model.dart';

import '../jsons/city_forecast_json.dart';
import '../jsons/weather_data_json.dart';

final weatherDataModel = WeatherDataModel.fromJson(weatherDataJson);

final cityForecastModel = CityForecastModel.fromJson(cityForecastJson);
