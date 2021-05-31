import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather_bloc/models/weather_model.dart';
import 'package:weather_bloc/services/weather_services.dart';

part 'currentweather_event.dart';
part 'currentweather_state.dart';

class CurrentweatherBloc
    extends Bloc<CurrentweatherEvent, CurrentweatherState> {
  CurrentweatherBloc() : super(CurrentweatherInitial());

  @override
  Stream<CurrentweatherState> mapEventToState(
    CurrentweatherEvent event,
  ) async* {
    if (event is CityNameEvent) {
      try {
        yield CurrentWeatherLoading();
        Weather result =
            await WeatherServices().getWeatherByCityName(cityName: event.city);
        yield CurrentWeatherSuccess(weather: result);
      } catch (e) {
        yield CurrentWeatherFailed(message: e.toString());
      }
    }
  }
}
