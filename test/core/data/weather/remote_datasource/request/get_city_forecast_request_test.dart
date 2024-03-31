import 'package:flutter_test/flutter_test.dart';
import 'package:rock_weather/core/data/weather/remote_datasource/request/get_city_forecast_request.dart';
import 'package:rock_weather/shared/http/app_request.dart';
import 'package:rock_weather/shared/res/app_constants.dart';

void main() {
  group(
    'GetCityForecastRequest',
    () {
      late GetCityForecastRequest request;

      setUp(
        () {
          request = GetCityForecastRequest(
            data: {
              'city_name': 'cityName',
              'apiKey': '1234',
              'units': 'metric',
            },
          );
        },
      );

      test(
        'should build with correct path',
        () {
          expect(request.path, '/forecast');
        },
      );

      test(
        'should be a GET method',
        () {
          expect(request.method, HttpMethod.get);
        },
      );

      test(
        'should have the query parameters with correct params',
        () {
          expect(
            request.queryParameters,
            {
              AppConstants.queryParameter: 'cityName',
              AppConstants.apiKeyParameter: '1234',
              AppConstants.unitsParameter: 'metric',
            },
          );
        },
      );
    },
  );
}
