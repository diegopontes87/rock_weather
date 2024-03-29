import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rock_weather/core/presentation/forecast/cubit/forecast_cubit.dart';
import 'package:rock_weather/dependencies/service_locator.dart';
import 'package:rock_weather/design/colors/app_colors.dart';
import 'package:rock_weather/design/widgets/custom_app_bar.dart';

class ForecastPage extends StatefulWidget {
  final String cityName;

  const ForecastPage({
    required this.cityName,
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
    _cubit = serviceLocator.get<ForecastCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: CustomAppBar(
            title: widget.cityName,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 48,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.backgroundGradient,
            ),
          ),
        ),
      ),
    );
  }
}
