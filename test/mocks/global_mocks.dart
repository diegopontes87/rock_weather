import 'package:mocktail/mocktail.dart';
import 'package:rock_weather/core/data/weather/local_datasource/weather_local_datasource.dart';
import 'package:rock_weather/core/data/weather/remote_datasource/weather_remote_datasource.dart';
import 'package:rock_weather/core/domain/weather/repository/weather_repository.dart';
import 'package:rock_weather/shared/adapters/local_storage/local_storage_adapter_impl.dart';
import 'package:rock_weather/shared/http/http_client.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockLocalStorageAdapterImpl extends Mock implements LocalStorageAdapterImpl {}

class MockWeatherLocalDataSource extends Mock implements WeatherLocalDataSource {}

class MockWeatherRemoteDataSource extends Mock implements WeatherRemoteDataSource {}

class MockWeatherRepository extends Mock implements WeatherRepository {}
