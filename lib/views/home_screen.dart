import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/widgets/current_weather.dart';

import 'package:weather_app/widgets/search_bar.dart';
import 'package:weather_app/widgets/weather_condition.dart';
import 'package:weather_app/widgets/weather_forcast.dart';
import 'package:weather_app/widgets/weather_location.dart';
import 'package:weather_app/widgets/weather_overview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WeatherProvider>(builder: (context, weatherProvider, child) {
        final weather = weatherProvider.weatherModel;
        final now = DateTime.now();
        final currentHour = now.hour;
        final List<Hour> filteredHours = weather?.forecast?.forecastday?.first.hour
                ?.where((hour) => DateTime.parse(hour.time!).hour >= currentHour)
                .toList() ??
            [];
        if (weatherProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (weather == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('No data found'),
                ElevatedButton(
                    onPressed: () {
                      weatherProvider.loadWeatherData();
                    },
                    child: const Text("Retry"))
              ],
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async => weatherProvider.refreshWeatherData(),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromRGBO(151, 171, 255, 1),
                  Color.fromRGBO(18, 53, 151, 1),
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: kTextTabBarHeight.h),
                  LocationSearchBar(provider: weatherProvider),
                  WeatherLocation(weather: weather),
                  CurrentWeatherDisplay(provider: weatherProvider, weather: weather),
                  WeatherCondition(weather: weather, provider: weatherProvider),
                  WeatherForecast(filteredHours: filteredHours, currentHour: currentHour, provider: weatherProvider),
                  WeatherOverview(weather: weather, provider: weatherProvider),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
