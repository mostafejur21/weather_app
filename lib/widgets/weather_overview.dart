import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/widgets/home_container.dart';

class WeatherOverview extends StatelessWidget {
  final WeatherModel? weather;

  const WeatherOverview({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300.h,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/curve.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 80.h),
            WeatherOverviewContainer(
              title1: 'Sunrise',
              value1: weather?.forecast?.forecastday?.first.astro?.sunrise ?? '',
              title2: 'Sunset',
              value2: weather?.forecast?.forecastday?.first.astro?.sunset ?? '',
              icon: Icons.wb_sunny_outlined,
            ),
            SizedBox(height: 15.h),
            WeatherOverviewContainer(
              title1: 'Uv Index',
              value1: weather?.current?.uv.toString() ?? '',
              title2: 'wind',
              value2: "${weather?.current?.windKph.toString()} km/h",
              icon: Icons.ac_unit,
            ),
          ],
        ),
      ),
    );
  }
}
