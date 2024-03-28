import 'package:get_it/get_it.dart';
import 'package:rock_weather/dependencies/home/home_dependencies.dart';

GetIt serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {
  registerHomeDependencies();
}
