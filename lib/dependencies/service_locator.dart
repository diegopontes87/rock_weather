import 'package:get_it/get_it.dart';
import 'package:rock_weather/dependencies/forecast/forecast_dependencies.dart';
import 'package:rock_weather/dependencies/global/global_dependencies.dart';
import 'package:rock_weather/dependencies/home/home_dependencies.dart';

GetIt serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {
  await registerGlobalDependencies().then(
    (_) {
      registerHomeDependencies();
      registerForecastDependencies();
    },
  );
}
