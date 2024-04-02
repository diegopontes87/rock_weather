import 'package:flutter/material.dart';
import 'package:rock_weather/design/colors/app_colors.dart';

class PageBackground extends StatelessWidget {
  final Widget child;

  const PageBackground({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        top: 0,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.backgroundGradient,
        ),
      ),
      child: child,
    );
  }
}
