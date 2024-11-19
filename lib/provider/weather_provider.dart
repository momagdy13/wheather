import 'package:flutter/material.dart';
import 'package:wheather/models/weather_models.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherModel? _weatherData;
  String? cityName;

  set weatherData(WeatherModel? weather) {
    _weatherData = weather;
    notifyListeners();
  }

  WeatherModel? get weatherData => _weatherData;
}
