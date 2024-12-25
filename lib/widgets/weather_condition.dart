import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather_models.dart';

class WeatherCondition extends StatelessWidget {
  final WeatherModel? weather;

  const WeatherCondition({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        Text(
          '${weather?.current?.condition?.text} - H ${weather?.forecast?.forecastday?.firstWhere((e) => e.date == DateFormat('yyyy-MM-dd').format(DateTime.now())).day?.maxtempC ?? ''}° FL ${weather?.current?.feelslikeC}°',
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}