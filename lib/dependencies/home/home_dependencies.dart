import 'package:rock_weather/core/presentation/home/cubit/home_cubit.dart';
import 'package:rock_weather/dependencies/service_locator.dart';

void registerHomeDependencies() {
  serviceLocator.registerLazySingleton(
    () => HomeCubit(),
  );
}
