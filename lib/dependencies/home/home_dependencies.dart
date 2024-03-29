import 'package:rock_weather/core/domain/weather/repository/weather_repository.dart';
import 'package:rock_weather/core/domain/weather/usecases/get_weather_by_city_usecase.dart';
import 'package:rock_weather/core/presentation/home/cubit/home_cubit.dart';
import 'package:rock_weather/dependencies/service_locator.dart';

void registerHomeDependencies() {
  serviceLocator.registerLazySingleton<GetWeatherByCityUsecase>(
    () => GetWeatherByCityUsecase(
      repository: serviceLocator.get<WeatherRepository>(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => HomeCubit(
      getWeatherByCityUsecase: serviceLocator.get<GetWeatherByCityUsecase>(),
    )..getWeatherForCities(),
  );
}
