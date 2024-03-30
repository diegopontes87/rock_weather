import 'package:go_router/go_router.dart';
import 'package:rock_weather/core/domain/weather/entities/weather_data_entity.dart';
import 'package:rock_weather/core/presentation/forecast/view/forecast_page.dart';
import 'package:rock_weather/core/presentation/home/view/home_page.dart';
import 'package:rock_weather/shared/router/app_routes.dart';

class AppRouter {
  static GoRouter? _routerInstance;
  AppRouter._();
  static GoRouter getRouter() {
    return _routerInstance ??= _initializeRouter();
  }

  static GoRouter _initializeRouter() {
    return GoRouter(
      initialLocation: AppRoutes.homePage,
      routes: [
        GoRoute(
          path: AppRoutes.homePage,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: AppRoutes.forecastPage,
          builder: (context, state) => ForecastPage(
            weatherData: state.extra as WeatherData,
          ),
        ),
      ],
    );
  }
}
