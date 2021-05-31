part of 'currentweather_bloc.dart';

@immutable
abstract class CurrentweatherState extends Equatable {
  @override
  List<Object> get props => [];
}

class CurrentweatherInitial extends CurrentweatherState {}

class CurrentWeatherLoading extends CurrentweatherState {}

class CurrentWeatherSuccess extends CurrentweatherState {
  final Weather weather;

  CurrentWeatherSuccess({this.weather});
}

class CurrentWeatherFailed extends CurrentweatherState {
  final String message;

  CurrentWeatherFailed({this.message});
}
