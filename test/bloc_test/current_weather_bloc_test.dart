import 'package:bloc_test/bloc_test.dart';
import 'package:weather_bloc/bloc/current_weather/currentweather_bloc.dart';

void main() {
  blocTest("should get CityNameEvent State",
      build: () => CurrentweatherBloc(),
      act: (bloc) => bloc.add(CityNameEvent("lagos")),
      expect: () => [CurrentWeatherLoading(), CurrentWeatherSuccess()]);
}
