import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:rock_weather/core/presentation/home/cubit/home_cubit.dart';
import 'package:rock_weather/core/presentation/home/widgets/app_text_field.dart';
import 'package:rock_weather/core/presentation/home/widgets/city_weather_card.dart';
import 'package:rock_weather/core/presentation/home/widgets/weather_loading.dart';
import 'package:rock_weather/dependencies/service_locator.dart';
import 'package:rock_weather/design/colors/app_colors.dart';
import 'package:rock_weather/design/widgets/custom_app_bar.dart';
import 'package:rock_weather/shared/res/app_assets.dart';
import 'package:rock_weather/shared/res/app_texts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit _cubit;
  late FocusNode searchFocusNode;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchFocusNode = FocusNode();
    searchController = TextEditingController();
    _cubit = serviceLocator.get<HomeCubit>();
    _searchControllerListener();
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  void _searchControllerListener() {
    searchController.addListener(() {
      _cubit.searchCity(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(56),
              child: CustomAppBar(
                title: AppTexts.appTitle,
                backButtonIsVisible: false,
              ),
            ),
            body: GestureDetector(
              onTap: () {
                searchFocusNode.unfocus();
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
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
                child: state.isLoading
                    ? const WeatherLoading()
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Gap(kToolbarHeight + AppBar().preferredSize.height),
                            AppTextField(
                              focusNode: searchFocusNode,
                              prefixIcon: Icons.search,
                              hintText: AppTexts.search,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              controller: searchController,
                              onFieldSubmitted: (v) {
                                searchFocusNode.unfocus();
                              },
                            ),
                            const Gap(12),
                            Column(
                              children: searchController.text.isEmpty
                                  ? state.citiesWeather.map(
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
                                    ).toList()
                                  : state.searchedCities.map(
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
                            Lottie.asset(
                              AppAssets.ballonAnimation,
                              animate: true,
                              repeat: false,
                            )
                          ],
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
