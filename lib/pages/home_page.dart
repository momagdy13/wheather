import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheather/models/weather_models.dart';
import 'package:wheather/pages/search_page.dart';
import 'package:wheather/provider/weather_provider.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onToggleTheme;

  HomePage({super.key, required this.onToggleTheme});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    weatherData =
        Provider.of<WeatherProvider>(context, listen: true).weatherData;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.black,
        actions: [
          IconButton(
            onPressed: widget.onToggleTheme,
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
              size: 30,
            ),
          ),
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
      body: weatherData == null
          ? const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'There is no weather 😔 Start',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      'Searching now 🔍',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    )
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 150),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Provider.of<WeatherProvider>(context).cityName!,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Updated: ${weatherData!.date}',
                      style: const TextStyle(fontSize: 18)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/images/clear.png'),
                        Text(
                          '${weatherData!.temp}°C',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          children: [
                            Text('Max Temp: ${weatherData!.maxTemp.toInt()}°C'),
                            Text('Min Temp: ${weatherData!.minTemp.toInt()}°C'),
                          ],
                        )
                      ],
                    ),
                  ),
                  Text(
                    weatherData!.weatherStateName,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
