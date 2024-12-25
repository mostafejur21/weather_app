import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/provider/weather_provider.dart';

class LocationSearchBar extends StatelessWidget {
  final WeatherProvider provider;

  const LocationSearchBar({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Container(
        height: 50.h,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: provider.searchController,
                decoration: const InputDecoration(
                  hintText: 'Enter city name',
                  hintStyle: TextStyle(color: Colors.white),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.white, fontSize: 18),
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                onFieldSubmitted: (value) {
                  provider.searchWeatherWithCityName(value).then((value) {
                    provider.searchController.clear();
                  });
                },
              ),
            ),
            IconButton(
              onPressed: () {
                provider.searchWeatherWithCityName(provider.searchController.text);
              },
              icon: const Icon(Icons.search, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}