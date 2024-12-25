import 'package:hive/hive.dart';
import 'package:weather_app/models/weather_models.dart';

class StorageServices {
  static const String weatherBox = "weatherBox";
  static const String lastUpdate = "lastUpdate";

  Future<void> saveWeatherData(WeatherModel weatherModel) async {
    final box = await Hive.openBox(weatherBox);
    await box.put("currentWeather", weatherModel);
    await box.put(lastUpdate, DateTime.now().toIso8601String());
  }

  WeatherModel? getWeatherData() {
    final box = Hive.box(weatherBox);
    return box.get("currentWeather");
  }

  bool shouldUpdate() {
    final box = Hive.box(weatherBox);
    final lastUpdate = box.get(StorageServices.lastUpdate);
    if (lastUpdate == null) {
      return true;
    }
    final lastUpdateDate = DateTime.parse(lastUpdate);
    final currentDate = DateTime.now();
    return currentDate.difference(lastUpdateDate).inMinutes > 30;
  }

  Future<void> initialize() async {
    await Hive.openBox(weatherBox);
  }
}
