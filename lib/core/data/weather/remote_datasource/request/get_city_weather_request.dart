import 'package:rock_weather/shared/http/app_request.dart';
import 'package:rock_weather/shared/res/app_constants.dart';

class GetCityWeatherRequest implements AppRequest {
  Map<String, dynamic> data;

  GetCityWeatherRequest({
    required this.data,
  });

  @override
  HttpMethod get method => HttpMethod.get;

  @override
  String get path => '/weather';

  @override
  Map<String, dynamic> get queryParameters => {
        AppConstants.queryParameter: data['city_name'],
        AppConstants.apiKeyParameter: data['apiKey'],
      };
}
