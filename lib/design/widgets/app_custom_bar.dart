import 'package:flutter/material.dart';
import 'package:rock_weather/design/colors/app_colors.dart';
import 'package:rock_weather/shared/res/app_texts.dart';

class AppCustomBar extends StatelessWidget {
  const AppCustomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      title: const Text(
        AppTexts.appTitle,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
