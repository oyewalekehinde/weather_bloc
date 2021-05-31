import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_bloc/models/weather_model.dart';
import 'package:weather_bloc/repository/get_weather.dart';
import 'package:weather_bloc/repository/weather_repository.dart';

class MockGetWeather extends Mock implements WeatherRepository {}

void main() {
  GetWeatherRepository repository;
  MockGetWeather mockGetWeather;

  setUp(() {
    mockGetWeather = MockGetWeather();
    repository = GetWeatherRepository(mockGetWeather);
  });
  final city = "Lagos";
  final weather = Weather();

  test(
    "should get current weather from repoitory",
    () async {
      when(mockGetWeather.getCurrentWeather(any))
          .thenAnswer((_) async => weather);

      final result = await repository.call(city);
      expect(result, weather);
      verify(mockGetWeather.getCurrentWeather(city));
      verifyNoMoreInteractions(mockGetWeather);
    },
  );
}
