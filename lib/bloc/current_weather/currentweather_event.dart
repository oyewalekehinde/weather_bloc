part of 'currentweather_bloc.dart';

@immutable
abstract class CurrentweatherEvent {}

class CityNameEvent extends CurrentweatherEvent {
  final String city;

  CityNameEvent(this.city);
}
