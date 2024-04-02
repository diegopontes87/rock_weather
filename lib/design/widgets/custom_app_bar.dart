import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rock_weather/design/colors/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool backButtonIsVisible;

  const CustomAppBar({
    super.key,
    required this.title,
    this.backButtonIsVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.blue,
      leading: backButtonIsVisible
          ? BackButton(
              onPressed: () => context.pop(),
              color: AppColors.white,
            )
          : null,
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
