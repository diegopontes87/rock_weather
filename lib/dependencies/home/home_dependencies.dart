import 'package:rock_weather/core/data/weather/local_datasource/weather_local_datasource.dart';
import 'package:rock_weather/core/data/weather/remote_datasource/weather_remote_datasource.dart';
import 'package:rock_weather/core/data/weather/repository/weather_repository_impl.dart';
import 'package:rock_weather/core/domain/weather/repository/weather_repository.dart';
import 'package:rock_weather/core/domain/weather/usecases/get_weather_by_city_usecase.dart';
import 'package:rock_weather/core/presentation/home/cubit/home_cubit.dart';
import 'package:rock_weather/dependencies/service_locator.dart';
import 'package:rock_weather/shared/adapters/local_storage/local_storage_adapter.dart';
import 'package:rock_weather/shared/http/http_client.dart';

void registerHomeDependencies() {
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

  serviceLocator.registerLazySingleton<GetWeatherByCityUsecase>(
    () => GetWeatherByCityUsecase(
      repository: serviceLocator.get<WeatherRepository>(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => HomeCubit(),
  );
}
