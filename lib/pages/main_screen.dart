import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc/bloc/current_weather/currentweather_bloc.dart';
import 'package:weather_bloc/widget/weather_widget.dart';

class MainScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final CurrentweatherBloc _currentBloc = CurrentweatherBloc();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height / 100;
    final double screenWidth = MediaQuery.of(context).size.width / 100;
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Weather App")),
        ),
        floatingActionButton: FloatingActionButton(
          key: ValueKey("button"),
          child: Icon(Icons.search),
          onPressed: () {
            _currentBloc.add(CityNameEvent(_controller.text));
          },
        ),
        body: Column(
          children: [
            Container(
              child: TextField(
                key: ValueKey("Enter city"),
                controller: _controller,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                  _currentBloc.add(CityNameEvent(_controller.text));
                },
                cursorColor: Colors.white54,
                decoration: InputDecoration(
                  hintStyle:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                  hintText: "Search City",
                  fillColor: Colors.grey,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        style: BorderStyle.none, color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        style: BorderStyle.none, color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                // height: screenHeight * 60,
                width: screenWidth * 100,
                child: BlocBuilder<CurrentweatherBloc, CurrentweatherState>(
                    bloc: _currentBloc,
                    builder: (context, state) {
                      if (state is CurrentWeatherLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is CurrentWeatherSuccess) {
                        return WeatherWidget(weather: state.weather);
                      } else if (state is CurrentWeatherFailed) {
                        return Center(
                            child: Text(
                          "${state.message}",
                          style: TextStyle(fontSize: 25),
                        ));
                      } else {
                        return SizedBox.shrink();
                      }
                    }),
              ),
            ),
          ],
        ));
  }
}
