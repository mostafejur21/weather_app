import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/widgets/home_container.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WeatherProvider>(builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final weather = provider.weatherModel;
        if (weather == null) {
          return Center(
            child: ElevatedButton(
              onPressed: () {
                provider.loadWeatherData();
              },
              child: const Text('Load Weather Data'),
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async => provider.refreshWeatherData(),
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
                  const Text(
                    'Dhaka',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 20,
                      ),
                      Text(
                        weather?.location?.name ?? '',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/partly_cloudy.png',
                        height: 130.h,
                        width: 135.w,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Flexible(
                        child: Text(
                          '${weather?.current?.tempC.toString()}°' ?? '',
                          style: TextStyle(color: Colors.white, fontSize: 80.sp, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Partly Cloudy - H ${weather?.forecast?.forecastday?[0].day?.maxtempC.toString()}° L ${weather?.forecast?.forecastday?[0].day?.avgtempC}°',
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(117, 149, 236, 1),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Center(
                              child: Text(
                                'Today',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(10, 30, 100, 1),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Center(
                              child: Text(
                                'Tomorrow',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 200.h,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      separatorBuilder: (context, index) => SizedBox(width: 10.w),
                      scrollDirection: Axis.horizontal,
                      itemCount: weather?.forecast?.forecastday?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 10.h,
                              ),
                              decoration: ShapeDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.white.withOpacity(0.3), Colors.white.withOpacity(0)],
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
                                    DateFormat('h a').format(
                                      DateTime.parse(weather?.forecast?.forecastday?[index].date ?? ''),
                                    ),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Image.asset(
                                    'assets/images/partly_cloudy.png',
                                    height: 50.h,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    '${weather?.forecast?.forecastday?[index].day?.maxtempC.toString()} °',
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
                            SizedBox(
                              height: 7.h,
                            ),
                            index == 0
                                ? Container(
                                    width: 12.h,
                                    height: 12.h,
                                    decoration: const ShapeDecoration(
                                      color: Colors.white,
                                      shape: OvalBorder(),
                                    ),
                                  )
                                : const SizedBox.shrink()
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 300.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/curve.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 80.h,
                          ),
                          const WeatherOverviewContainer(
                            title1: 'Sunrise',
                            value1: '5:00 AM',
                            title2: 'Sunset',
                            value2: '6:00 PM',
                            icon: Icons.wb_sunny_outlined,
                          ),
                          SizedBox(height: 15.h),
                          const WeatherOverviewContainer(
                            title1: 'Visibility',
                            value1: '10 km',
                            title2: 'UV Index',
                            value2: '3',
                            icon: Icons.ac_unit,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
