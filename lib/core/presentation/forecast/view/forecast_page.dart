import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:rock_weather/core/domain/weather/entities/weather_data_entity.dart';
import 'package:rock_weather/core/presentation/forecast/cubit/forecast_cubit.dart';
import 'package:rock_weather/core/presentation/forecast/widgets/forecast_detail_card.dart';
import 'package:rock_weather/core/presentation/forecast/widgets/weather_detail_card.dart';
import 'package:rock_weather/dependencies/service_locator.dart';
import 'package:rock_weather/design/colors/app_colors.dart';
import 'package:rock_weather/design/widgets/custom_app_bar.dart';
import 'package:rock_weather/design/widgets/page_background.dart';
import 'package:rock_weather/design/widgets/weather_loading.dart';
import 'package:rock_weather/shared/res/app_assets.dart';
import 'package:rock_weather/shared/res/app_constants.dart';
import 'package:rock_weather/shared/res/app_texts.dart';
import 'package:rock_weather/shared/utils/error_utils.dart';
import 'package:rock_weather/shared/utils/weather_utils.dart';

class ForecastPage extends StatefulWidget {
  final WeatherData weatherData;

  const ForecastPage({
    required this.weatherData,
    super.key,
  });

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  late ForecastCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = serviceLocator.get<ForecastCubit>(param1: widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocBuilder<ForecastCubit, ForecastState>(
        builder: (context, state) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: CustomAppBar(
                title: widget.weatherData.locationName ?? '',
              ),
            ),
            body: PageBackground(
              child: state.isLoading
                  ? const WeatherLoading(
                      assetAnimation: AppAssets.weatherRainAnimation,
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppTexts.today,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Gap(12),
                          Row(
                            children: [
                              WeatherDetailCard(
                                title: 'Wind',
                                subtitle: WeatherUtils.metersPerSecondToKilometersPerHour(widget.weatherData.wind!.speed ?? 0),
                              ),
                              const Gap(8),
                              WeatherDetailCard(
                                title: 'Temp',
                                subtitle: '${widget.weatherData.coreWeatherInfo?.temp ?? 0}${AppConstants.celsiusTemp}',
                              ),
                              const Gap(8),
                              WeatherDetailCard(
                                title: 'Humidity',
                                subtitle: '${widget.weatherData.coreWeatherInfo?.humidity}%',
                              ),
                            ],
                          ),
                          const Gap(12),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Forecast - Next 5 days',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Gap(12),
                          if (state.isError)
                            Text(
                              ErrorUtils.handleError(errorType: state.errorType!),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          Column(
                            children: state.weathersByDay.entries.map((weather) {
                              return Column(
                                children: [
                                  ForecastDetailCard(
                                    weathers: weather.value,
                                  ),
                                  const Gap(12)
                                ],
                              );
                            }).toList(),
                          ),
                          const Gap(24),
                        ],
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
