import 'package:flutter/material.dart';
import 'package:weather_bloc/models/weather_model.dart';
import 'package:weather_bloc/utils/get_weather_image.dart';
import 'package:intl/intl.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;
  WeatherWidget({Key key, @required this.weather}) : super(key: key);
  final f = new DateFormat('hh:mm a');

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height / 100;
    final double screenWidth = MediaQuery.of(context).size.width / 100;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 2, vertical: screenHeight * 2),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              "assets/" + weatherIcon(weather.weather.first.description),
            ),
            fit: BoxFit.cover),
      ),
      child: Container(
        height: screenHeight * 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${f.format(DateTime.now())}",
              style: TextStyle(fontSize: 80),
            ),
            Text(
              "${(weather.main.temp - 273).toStringAsFixed(1)}",
              style: TextStyle(fontSize: 120, color: Colors.white),
            ),
            Text(
              "Weather condition: ${weather.weather.first.description}",
              style: TextStyle(fontSize: 25),
            ),
            Spacer(),
            Container(
              height: screenHeight * 10,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  weatherDetails("   " + weather.main.humidity.toString() + "%",
                      "Humidity"),
                  verticalLine(),
                  weatherDetails(
                      weather.main.pressure.toString() + " hPa", "Pressure"),
                  verticalLine(),
                  weatherDetails(
                      weather.wind.speed.toString() + " m/s", "Wind speed"),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 5,
            )
          ],
        ),
      ),
    );
  }

  Widget weatherDetails(String number, String details) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text: number + "\n",
              children: [TextSpan(text: details)],
            ),
          )
        ],
      ),
    );
  }

  Widget verticalLine() {
    return Container(
      height: 20,
      child: VerticalDivider(
        color: Colors.white,
        width: 10,
      ),
    );
  }
}
