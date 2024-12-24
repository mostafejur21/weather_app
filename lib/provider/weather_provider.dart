import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/services/weather_services.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherServices _weatherServices = WeatherServices();

  WeatherModel? _weatherModel;
  bool _isLoading = false;

  WeatherModel? get weatherModel => _weatherModel;
  bool get isLoading => _isLoading;

  Future<void> loadWeatherData(double lat, double lng) async {
    _isLoading = true;
    notifyListeners();
    try {
      final weather = await _weatherServices.getWeather(lat, lng);
      _weatherModel = weather;
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
    _isLoading = false;
    notifyListeners();
  }
}
