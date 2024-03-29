import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:rock_weather/core/presentation/home/cubit/home_cubit.dart';
import 'package:rock_weather/core/presentation/home/widgets/city_weather_card.dart';
import 'package:rock_weather/core/presentation/home/widgets/weather_loading.dart';
import 'package:rock_weather/dependencies/service_locator.dart';
import 'package:rock_weather/design/colors/app_colors.dart';
import 'package:rock_weather/shared/res/app_assets.dart';
import 'package:rock_weather/shared/res/app_texts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = serviceLocator.get<HomeCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppColors.blue,
              title: const Text(
                AppTexts.appTitle,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 48),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: AppColors.backgroundGradient,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Visibility(
                    visible: state.isLoading,
                    child: const Expanded(
                      child: WeatherLoading(),
                    ),
                  ),
                  Visibility(
                    visible: !state.isLoading,
                    maintainAnimation: true,
                    maintainState: true,
                    child: AnimatedOpacity(
                      opacity: state.isLoading ? 0 : 1,
                      curve: Curves.easeInOut,
                      duration: const Duration(seconds: 1),
                      child: Column(
                        children: state.citiesWeather.map(
                          (weather) {
                            return Column(
                              children: [
                                CityWeatherCard(
                                  weatherData: weather,
                                ),
                                const Gap(12),
                              ],
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (!state.isLoading)
                    Lottie.asset(
                      AppAssets.ballonAnimation,
                      repeat: false,
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
