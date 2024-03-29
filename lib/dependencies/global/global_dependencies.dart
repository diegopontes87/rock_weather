import 'package:dio/dio.dart';
import 'package:rock_weather/core/data/weather/local_datasource/weather_local_datasource.dart';
import 'package:rock_weather/core/data/weather/remote_datasource/weather_remote_datasource.dart';
import 'package:rock_weather/core/data/weather/repository/weather_repository_impl.dart';
import 'package:rock_weather/core/domain/weather/repository/weather_repository.dart';
import 'package:rock_weather/dependencies/service_locator.dart';
import 'package:rock_weather/env/env.dart';
import 'package:rock_weather/shared/adapters/connection/connection_adapter.dart';
import 'package:rock_weather/shared/adapters/connection/connection_adapter_impl.dart';
import 'package:rock_weather/shared/adapters/local_storage/local_storage_adapter.dart';
import 'package:rock_weather/shared/adapters/local_storage/local_storage_adapter_impl.dart';
import 'package:rock_weather/shared/http/http_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> registerGlobalDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  serviceLocator.registerSingleton<LocalStorageAdapter>(
    LocalStorageAdapterImpl(
      sharedPreferences: sharedPreferences,
    ),
  );

  serviceLocator.registerLazySingleton(
    () => WeatherRemoteDataSource(
      client: serviceLocator.get<HttpClient>(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => WeatherLocalDataSource(
      localStorageAdapter: serviceLocator.get<LocalStorageAdapter>(),
    ),
  );

  serviceLocator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      localDataSource: serviceLocator.get<WeatherLocalDataSource>(),
      remoteDataSource: serviceLocator.get<WeatherRemoteDataSource>(),
    ),
  );

  serviceLocator.registerSingleton<ConnectionAdapter>(
    ConnectionAdapterImpl(),
  );

  serviceLocator.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: Env.appUrl,
        receiveTimeout: const Duration(seconds: 3),
        connectTimeout: const Duration(seconds: 5),
      ),
    ),
  );

  serviceLocator.registerSingleton<HttpClient>(
    HttpClient(
      dio: serviceLocator.get<Dio>(),
      connectionAdapter: serviceLocator.get<ConnectionAdapter>(),
    ),
  );
}
