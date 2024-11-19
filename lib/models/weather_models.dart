class WeatherModel {
  String date;
  double temp;
  double maxTemp;
  double minTemp;
  String weatherStateName;

  WeatherModel(
      {required this.date,
      required this.maxTemp,
      required this.minTemp,
      required this.weatherStateName,
      required this.temp});

  factory WeatherModel.formJson(dynamic data) {
    var jsonData = data['forecast']["forecastday"][0]['day'];

    return WeatherModel(
        date: data['location']["localtime"],
        temp: jsonData['avgtemp_c'],
        maxTemp: jsonData['maxtemp_c'],
        minTemp: jsonData['mintemp_c'],
        weatherStateName: jsonData['condition']['text']);
  }

  @override
  String toString() {
    return 'date $date  temp= $temp maxTemp = $maxTemp minTemp = $minTemp weatherStateName = $weatherStateName  ';
  }
}
