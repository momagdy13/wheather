import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wheather/models/weather_models.dart';

class WeatherServices {
  Future<WeatherModel?> getWeather({required String cityName}) async {
    WeatherModel? wheatherModel;
    try {
      String baseUrl = 'http://api.weatherapi.com/v1';
      String apiKey = '6ff6ddbc27cd4cc5bf2235430240702&q';
      Uri url =
          Uri.parse('$baseUrl/forecast.json?key=$apiKey=$cityName&days=7');
      http.Response response = await http.get(url);

      Map<String, dynamic> data = jsonDecode(response.body);
      wheatherModel = WeatherModel.formJson(data);
    } catch (e) {
      print(e);
    }

    return wheatherModel;
  }
}
