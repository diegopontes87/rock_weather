import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:rock_weather/design/colors/app_colors.dart';
import 'package:rock_weather/shared/res/app_texts.dart';

class WeatherLoading extends StatelessWidget {
  final String assetAnimation;
  const WeatherLoading({
    super.key,
    required this.assetAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            assetAnimation,
          ),
          const Gap(8),
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
