import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/models/weather_models.dart';

class WeatherLocation extends StatelessWidget {
  final WeatherModel? weather;

  const WeatherLocation({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          weather?.location?.name ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 15.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on,
              color: Colors.white,
              size: 20,
            ),
            Text(
              weather?.location?.name ?? '',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}