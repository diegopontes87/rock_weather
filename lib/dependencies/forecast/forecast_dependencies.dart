import 'package:rock_weather/core/presentation/forecast/cubit/forecast_cubit.dart';
import 'package:rock_weather/dependencies/service_locator.dart';

void registerForecastDependencies() {
  serviceLocator.registerLazySingleton(
    () => ForecastCubit(),
  );
}
