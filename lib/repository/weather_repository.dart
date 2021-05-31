import 'package:weather_bloc/models/weather_model.dart';

abstract class WeatherRepository {
  Future<Weather> getCurrentWeather(String city);
}
