import 'package:rock_weather/core/domain/weather/entities/weather_data_entity.dart';
import 'package:rock_weather/core/domain/weather/repository/weather_repository.dart';
import 'package:rock_weather/core/domain/weather/usecases/get_forecast_by_city_usecase.dart';
import 'package:rock_weather/core/presentation/forecast/cubit/forecast_cubit.dart';
import 'package:rock_weather/dependencies/service_locator.dart';

void registerForecastDependencies() {
  serviceLocator.registerLazySingleton(
    () => GetForecastByCityUsecase(
      repository: serviceLocator.get<WeatherRepository>(),
    ),
  );
  serviceLocator.registerFactoryParam<ForecastCubit, WeatherData, void>(
    (weatherData, _) => ForecastCubit(
      weatherData: weatherData,
      getForecastByCityUsecase: serviceLocator.get<GetForecastByCityUsecase>(),
    )..getForecastByCity(),
  );
}
