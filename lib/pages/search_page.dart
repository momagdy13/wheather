// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheather/models/weather_models.dart';
import 'package:wheather/provider/weather_provider.dart';
import 'package:wheather/services/weather_services.dart';

class SearchPage extends StatelessWidget {
  String? cityName;
  VoidCallback? updateUi;

  SearchPage({this.updateUi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Search a City',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextField(
            onChanged: (data) {
              cityName = data;
            },
            onSubmitted: (data) async {
              cityName = data;

              WeatherServices services = WeatherServices();
              WeatherModel? weather =
                  await services.getWeather(cityName: cityName!);
              Provider.of<WeatherProvider>(context, listen: false).weatherData =
                  weather;
              Provider.of<WeatherProvider>(context, listen: false).cityName =
                  cityName;

              Navigator.pop(context);
            },
            decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                hintText: 'Enter City ',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
                label: Text('Search')),
          ),
        ),
      ),
    );
  }
}
