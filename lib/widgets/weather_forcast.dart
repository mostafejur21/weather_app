import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/provider/weather_provider.dart';

class WeatherForecast extends StatelessWidget {
  final List<Hour> filteredHours;
  final int currentHour;
  final WeatherProvider provider;

  const WeatherForecast({super.key, required this.filteredHours, required this.currentHour, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            separatorBuilder: (context, index) => SizedBox(width: 10.w),
            scrollDirection: Axis.horizontal,
            itemCount: filteredHours.length,
            itemBuilder: (context, index) {
              final hourData = filteredHours[index];
              final hourTime = DateTime.parse(hourData.time!);
              final isNow = hourTime.hour == currentHour;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withOpacity(0.3),
                          Colors.white.withOpacity(0),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1.5.w,
                          strokeAlign: BorderSide.strokeAlignInside,
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isNow ? 'Now' : DateFormat('h a').format(hourTime),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Image.asset(
                          provider.getWeatherIcon(hourData.condition?.text ?? ''),
                          height: 50.h,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          '${provider.isCelcius ? hourData.tempC : hourData.tempF} °',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 7.h),
                  isNow
                      ? Container(
                          width: 12.h,
                          height: 12.h,
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: OvalBorder(),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
