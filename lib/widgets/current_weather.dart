import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/provider/weather_provider.dart';

class CurrentWeatherDisplay extends StatelessWidget {
  final WeatherProvider provider;
  final WeatherModel? weather;

  const CurrentWeatherDisplay({super.key, required this.provider, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          provider.getWeatherIcon(weather?.current?.condition?.text ?? ''),
          height: 130.h,
          width: 135.w,
        ),
        SizedBox(width: 20.w),
        Flexible(
          child: Text(
            '${weather?.current?.tempC.toString()}°',
            style: TextStyle(color: Colors.white, fontSize: 80.sp, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
