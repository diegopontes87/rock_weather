import 'package:dio/dio.dart';
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
