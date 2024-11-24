import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheather/cubits/weather_cubit/weather_state.dart';
import 'package:wheather/models/weather_models.dart';
import 'package:wheather/services/weather_services.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.weatherService) : super(WeatherInitial());
  WeatherServices weatherService;
  WeatherModel? weatherModel;
  String? cityName;
  void getWeather({required String cityName}) async {
    emit(WeatherLoading());
    try {
      weatherModel = await weatherService.getWeather(cityName: cityName);
      emit(WeatherSuccess(weatherModel: weatherModel!));
    } catch (e) {
      emit(WeatherFailure());
      print(e);
    }
  }
}
