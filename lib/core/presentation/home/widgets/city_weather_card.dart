import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rock_weather/core/domain/weather/entities/weather_data_entity.dart';
import 'package:rock_weather/design/colors/app_colors.dart';
import 'package:rock_weather/shared/res/app_constants.dart';
import 'package:rock_weather/shared/res/app_texts.dart';
import 'package:rock_weather/shared/utils/date_time_utils.dart';
import 'package:rock_weather/shared/utils/temperature_utils.dart';

class CityWeatherCard extends StatelessWidget {
  final WeatherData weatherData;

  const CityWeatherCard({
    super.key,
    required this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.darkBlue,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: Text(
                weatherData.locationName ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateTimeUtils.isDateToday(weatherData.dataCalculationTime ?? 0) ? AppTexts.today : '',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  weatherData.weathers!.first.status ?? '',
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
                  TemperatureUtils.kelvinToCelsius(weatherData.coreWeatherInfo?.temp ?? 0),
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
              height: 60,
              width: 60,
              child: CachedNetworkImage(
                imageUrl: AppConstants.iconUrl(weatherData.weathers!.first.icon!),
              ),
            ),
          ],
        ));
  }
}
