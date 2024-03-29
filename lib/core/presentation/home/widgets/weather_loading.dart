import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rock_weather/design/colors/app_colors.dart';
import 'package:rock_weather/shared/res/app_assets.dart';
import 'package:rock_weather/shared/res/app_texts.dart';

class WeatherLoading extends StatelessWidget {
  const WeatherLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            AppAssets.weatherAnimation,
          ),
          const Text(
            AppTexts.loading,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
