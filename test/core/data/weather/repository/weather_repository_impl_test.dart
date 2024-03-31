import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rock_weather/core/data/weather/local_datasource/weather_local_datasource.dart';

import '../../../../mocks/global_mocks.dart';
import '../../../../models/models.dart';

void main() {
  late MockLocalStorageAdapterImpl mockLocalStorageAdapter;
  late WeatherLocalDataSource weatherLocalDataSource;
  String cityName = 'São Paulo';

  setUp(
    () {
      mockLocalStorageAdapter = MockLocalStorageAdapterImpl();
      weatherLocalDataSource = WeatherLocalDataSource(
        localStorageAdapter: mockLocalStorageAdapter,
      );
    },
  );

  group(
    'saveCityWeatherLocally',
    () {
      test(
        'should save city weather locally',
        () async {
          final weatherDataJson = weatherDataModel.toJson();
          when(() => mockLocalStorageAdapter.setString(cityName, jsonEncode(weatherDataJson))).thenAnswer((_) async {});

          await weatherLocalDataSource.saveCityWeatherLocally(cityName: cityName, weatherDataModel: weatherDataModel);

          verify(() => mockLocalStorageAdapter.setString(cityName, jsonEncode(weatherDataJson))).called(1);
        },
      );
    },
  );

  group(
    'getCityWeatherLocally',
    () {
      test(
        'should return a WeatherDataModel if city exists locally',
        () async {
          final weatherDataJson = weatherDataModel.toJson();
          when(() => mockLocalStorageAdapter.getString(cityName)).thenAnswer((_) async => jsonEncode(weatherDataJson));

          final result = await weatherLocalDataSource.getCityWeatherLocally(cityName: cityName);

          verify(() => mockLocalStorageAdapter.getString(cityName)).called(1);

          expect(result, weatherDataModel);
        },
      );

      test(
        'should return null if city doesnt exists locally',
        () async {
          when(() => mockLocalStorageAdapter.getString(cityName)).thenAnswer((_) async => '');

          final result = await weatherLocalDataSource.getCityWeatherLocally(cityName: cityName);

          verify(() => mockLocalStorageAdapter.getString(cityName)).called(1);

          expect(result, null);
        },
      );
    },
  );

  group(
    'saveCityForecastLocally',
    () {
      test(
        'should save city forecast locally',
        () async {
          final cityForecastJson = cityForecastModel.toJson();
          when(() => mockLocalStorageAdapter.setString('${cityName}forecastKey', jsonEncode(cityForecastJson))).thenAnswer((_) async {});

          await weatherLocalDataSource.saveCityForecastLocally(cityName: cityName, cityForecastModel: cityForecastModel);

          verify(() => mockLocalStorageAdapter.setString('${cityName}forecastKey', jsonEncode(cityForecastJson))).called(1);
        },
      );
    },
  );

  group(
    'getCityForecastLocally',
    () {
      test(
        'should return a CityForecastModel if city exists locally',
        () async {
          final cityForecastJson = cityForecastModel.toJson();
          when(() => mockLocalStorageAdapter.getString('${cityName}forecastKey')).thenAnswer((_) async => jsonEncode(cityForecastJson));

          final result = await weatherLocalDataSource.getCityForecastLocally(cityName: cityName);

          verify(() => mockLocalStorageAdapter.getString('${cityName}forecastKey')).called(1);

          expect(result, cityForecastModel);
        },
      );

      test(
        'should return null if city doesnt exists locally',
        () async {
          when(() => mockLocalStorageAdapter.getString('${cityName}forecastKey')).thenAnswer((_) async => '');

          final result = await weatherLocalDataSource.getCityForecastLocally(cityName: cityName);

          verify(() => mockLocalStorageAdapter.getString('${cityName}forecastKey')).called(1);

          expect(result, null);
        },
      );
    },
  );
}
