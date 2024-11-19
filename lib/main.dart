import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheather/pages/home_page.dart';
import 'package:wheather/provider/weather_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => WeatherProvider(),
    child: WheatherApp(),
  ));
}

class WheatherApp extends StatefulWidget {
  @override
  _WheatherAppState createState() => _WheatherAppState();
}

class _WheatherAppState extends State<WheatherApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
          foregroundColor: Colors.white,
        ),
      ),
      themeMode: _themeMode,
      home: HomePage(
        onToggleTheme: toggleTheme,
      ),
    );
  }
}
