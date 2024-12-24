import 'dart:convert';

import 'package:weather_app/config/constant.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:http/http.dart' as http;

class WeatherServices {
  Future<WeatherModel> getWeather(double lat, double lng) async {
    final response = await http
        .get(Uri.parse('${AppConstants.BASE_URL}/forecast.json?key=${AppConstants.API_KEY}&q=$lat,$lng&days=3'));
    try {
      if (response.statusCode == 200) {
        try {
          return WeatherModel.fromJson(jsonDecode(response.body));
        } catch (e) {
          throw Exception('Failed to load weather data $e');
        }
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to load weather data $e');
    }
  }
}
