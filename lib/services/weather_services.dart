import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:weather_bloc/models/weather_model.dart';
import 'package:http/http.dart' as http;

const String API_KEY = "60f988bd707e9624b1fc62ad190c8c6c";
const String BASE_URL = "https://api.openweathermap.org/data/2.5/weather?q=";

abstract class WeatherHttp {
  Future<Weather> getWeatherByCityName();
}

class WeatherServices implements WeatherHttp {
  Future<Weather> getWeatherByCityName({@required String cityName}) async {
    final String url = "$BASE_URL$cityName&appid=$API_KEY";
    try {
      var response = await http.get(Uri.parse(url));
      switch (response.statusCode) {
        case 200:
          var responseBody = jsonDecode(response.body);
          return Weather.fromJson(responseBody);
          break;
        case 401:
          throw Exception("Unauthorized");
        case 404:
          throw Exception("Error loading page");
        default:
          throw "City Not Found";
      }
    } catch (e) {
      if (e is SocketException) {
        throw "Network Problem";
      } else {
        throw Exception(e);
      }
    }
  }
}
