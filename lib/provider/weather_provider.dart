import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/services/location_services.dart';
import 'package:weather_app/services/weather_services.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherServices _weatherServices = WeatherServices();
  final LocationService _locationService = LocationService();
  final TextEditingController searchController = TextEditingController();

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
        lat: position.latitude,
        lng: position.longitude,
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

  Future<void> searchWeatherWithCityName(String cityName) async {
    try {
      _isLoading = true;
      notifyListeners();
      final weather = await _weatherServices.getWeather(cityName: cityName);
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

  String getWeatherIcon(String condition) {
    switch (condition) {
      case 'Sunny':
        return "assets/icons/sun.png";
      case 'Clear':
        return "assets/icons/sun.png";
      case 'Clouds':
        return "assets/icons/sun-clouds.png";
      case 'Rain':
        return "assets/icons/sun-clouds-rain.png";
      case 'Snow':
        return "assets/icons/clouds-snow.png";
      case 'Fog':
        return "assets/icons/clouds-snow.png";
      case 'Mist':
        return "assets/icons/clouds-snow.png";
      case 'Haze':
        return "assets/icons/clouds-snow.png";
      case 'Thunderstorm':
        return "assets/icons/clouds-snow.png";
      default:
        return "assets/icons/clouds-snow.png";
    }
  }
}
