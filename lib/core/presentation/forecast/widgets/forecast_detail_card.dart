import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rock_weather/core/domain/weather/entities/weather_data_entity.dart';
import 'package:rock_weather/design/colors/app_colors.dart';
import 'package:rock_weather/shared/res/app_constants.dart';
import 'package:rock_weather/shared/utils/date_time_utils.dart';

class ForecastDetailCard extends StatelessWidget {
  final List<WeatherData> weathers;

  const ForecastDetailCard({
    super.key,
    required this.weathers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.darkBlue,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateTimeUtils.formatDateAbbreviated(weathers.first.dataCalculationTime ?? 0),
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    weathers.first.weathers!.first.status ?? '',
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${weathers.first.coreWeatherInfo?.temp ?? 0}',
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 32,
                    ),
                  ),
                  const Gap(4),
                  const Text(
                    AppConstants.celsiusTemp,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 70,
                width: 70,
                child: CachedNetworkImage(
                  imageUrl: AppConstants.iconUrl(weathers.first.weathers!.first.icon!),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: AppColors.blue,
            ),
            child: Column(
              children: weathers.sublist(1).map(
                (weather) {
                  return Row(
                    children: [
                      Text(
                        DateTimeUtils.getHour(weather.dataCalculationTime ?? 0),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${weather.coreWeatherInfo?.temp ?? 0}${AppConstants.celsiusTemp} - ',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        weather.weathers!.first.status ?? '',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 35,
                        width: 35,
                        child: CachedNetworkImage(
                          imageUrl: AppConstants.iconUrl(weather.weathers!.first.icon!),
                        ),
                      ),
                    ],
                  );
                },
              ).toList(),
            ),
          ),
        )
      ],
    );
  }
}
