import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/services/location_services.dart';
import 'package:weather_app/services/weather_services.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherServices _weatherServices = WeatherServices();
  final LocationService _locationService = LocationService();

  WeatherModel? _weatherModel;
  bool _isLoading = false;

  WeatherModel? get weatherModel => _weatherModel;
  bool get isLoading => _isLoading;

  Future<void> loadWeatherData() async {
    final position = await _locationService.getCurrentLocation();
    _isLoading = true;
    notifyListeners();
    try {
      final weather = await _weatherServices.getWeather(
        position.latitude,
        position.longitude,
      );
      _weatherModel = weather;
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshWeatherData() async {
    try {
      _isLoading = true;
      notifyListeners();
      await loadWeatherData();
    } catch (e) {
      throw e;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
