import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheather/cubits/weather_cubit/weather_cubit.dart';
import 'package:wheather/cubits/weather_cubit/weather_state.dart';
import 'package:wheather/models/weather_models.dart';
import 'package:wheather/pages/search_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Helper method for dynamic weather image retrieval
  String getWeatherImage(String state) {
    switch (state) {
      case 'Clear':
        return 'assets/images/clear.png';
      case 'Rainy':
        return 'assets/images/rainy.png';
      case 'Cloudy':
        return 'assets/images/cloudy.png';
      default:
        return 'assets/images/clear.png';
    }
  }

  WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage();
              }));
            },
            icon: const Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
        title: const Text(
          'Weather App',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WeatherSuccess) {
            weatherData = state.weatherModel;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      BlocProvider.of<WeatherCubit>(context).cityName!,
                      style: const TextStyle(
                        fontSize: 80,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Updated: ${weatherData!.date ?? 'N/A'}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          getWeatherImage(weatherData!.weatherStateName),
                          width: 100,
                          height: 100,
                        ),
                        Text(
                          '${weatherData!.temp}°C',
                          style: const TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              'Max: ${weatherData!.maxTemp.toInt()}°C',
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              'Min: ${weatherData!.minTemp.toInt()}°C',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Text(
                      weatherData!.weatherStateName,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is WeatherFailure) {
            return FailedScreen();
          } else {
            return DefaultScreen();
          }
        },
      ),
    );
  }
}

class FailedScreen extends StatelessWidget {
  const FailedScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Something went wrong!',
            style: TextStyle(fontSize: 24, color: Colors.red),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class DefaultScreen extends StatelessWidget {
  const DefaultScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'No weather data available 😔',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
            },
            child: const Text('Search for Weather'),
          ),
        ],
      ),
    );
  }
}
