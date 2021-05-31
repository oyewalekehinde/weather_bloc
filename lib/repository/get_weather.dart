import 'package:weather_bloc/models/weather_model.dart';
import 'package:weather_bloc/repository/weather_repository.dart';

abstract class GetWeather {
  Future<Weather> call(String city);
}

class GetWeatherRepository implements GetWeather {
  final WeatherRepository repository;

  GetWeatherRepository(this.repository);
  Future<Weather> call(String city) async {
    return await repository.getCurrentWeather(city);
  }
}
