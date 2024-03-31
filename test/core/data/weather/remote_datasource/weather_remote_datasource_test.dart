import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rock_weather/core/data/weather/models/city_forecast_model.dart';
import 'package:rock_weather/core/data/weather/models/weather_data_model.dart';
import 'package:rock_weather/core/data/weather/remote_datasource/request/get_city_forecast_request.dart';
import 'package:rock_weather/core/data/weather/remote_datasource/request/get_city_weather_request.dart';
import 'package:rock_weather/core/data/weather/remote_datasource/weather_remote_datasource.dart';
import 'package:rock_weather/shared/errors/app_error.dart';
import 'package:rock_weather/shared/http/http_client.dart';

import '../../../../jsons/city_forecast_json.dart';
import '../../../../jsons/weather_data_json.dart';
import '../../../../mocks/global_mocks.dart';

class FakeGetCityWeatherRequest extends Fake implements GetCityWeatherRequest {}

class FakeGetCityForecastRequest extends Fake implements GetCityForecastRequest {}

void main() {
  group(
    'WeatherRemoteDatasource',
    () {
      late MockHttpClient mockHttpClient;
      late WeatherRemoteDataSource weatherRemoteDataSource;

      setUp(
        () {
          mockHttpClient = MockHttpClient();
          weatherRemoteDataSource = WeatherRemoteDataSource(client: mockHttpClient);
        },
      );

      setUpAll(() {
        registerFallbackValue(FakeGetCityWeatherRequest());
        registerFallbackValue(FakeGetCityForecastRequest());
      });

      void mockSuccessRequest(
        HttpClient client, {
        Map<String, dynamic>? json,
      }) {
        when(
          () => client.request(any()),
        ).thenAnswer(
          (_) async => json ?? {},
        );
      }

      void mockErrorRequest(
        HttpClient client, {
        Object? exception,
      }) {
        when(
          () => client.request(any()),
        ).thenThrow(
          exception ?? AppError(errorType: AppErrorType.serviceError),
        );
      }

      group(
        'getCityWeather',
        () {
          test(
            'should use GetCityWeatherRequest as request and return WeatherDataModel as response',
            () async {
              mockSuccessRequest(
                mockHttpClient,
                json: weatherDataJson,
              );

              final result = await weatherRemoteDataSource.getCityWeather(cityName: 'São Paulo');
              expect(result.tryGetSuccess(), WeatherDataModel.fromJson(weatherDataJson));
              verify(() => mockHttpClient.request(any<GetCityWeatherRequest>())).called(1);
            },
          );

          test(
            'should return an AppError when exception is thrown',
            () async {
              mockErrorRequest(
                mockHttpClient,
              );

              final result = await weatherRemoteDataSource.getCityWeather(cityName: 'São Paulo');
              final isError = result.isError();
              expect(isError, true);
            },
          );
        },
      );

      group(
        'getCityForecast',
        () {
          test(
            'should use GetCityForecastRequest as request and return CityForecastModel as response',
            () async {
              mockSuccessRequest(
                mockHttpClient,
                json: cityForecastJson,
              );

              final result = await weatherRemoteDataSource.getCityForecast(cityName: 'Silverstone');
              expect(result.tryGetSuccess(), CityForecastModel.fromJson(cityForecastJson));
              verify(() => mockHttpClient.request(any<GetCityForecastRequest>())).called(1);
            },
          );

          test(
            'should return an AppError when exception is thrown',
            () async {
              mockErrorRequest(
                mockHttpClient,
              );

              final result = await weatherRemoteDataSource.getCityForecast(cityName: 'Silverstone');
              final isError = result.isError();
              expect(isError, true);
            },
          );
        },
      );
    },
  );
}
