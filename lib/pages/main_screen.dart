import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc/bloc/current_weather/currentweather_bloc.dart';
import 'package:weather_bloc/utils/get_weather_image.dart';

class MainScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final CurrentweatherBloc _currentBloc = CurrentweatherBloc();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height / 100;
    double screenWidth = MediaQuery.of(context).size.width / 100;
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Weather App")),
        ),
        body: Container(
          height: screenHeight * 100,
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  child: TextField(
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
                Container(
                  height: screenHeight * 60,
                  width: screenWidth * 100,
                  child: BlocBuilder<CurrentweatherBloc, CurrentweatherState>(
                      bloc: _currentBloc,
                      builder: (context, state) {
                        if (state is CurrentWeatherLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is CurrentWeatherSuccess) {
                          return Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      "assets/" +
                                          weatherIcon(state.weather.weather
                                              .first.description),
                                    ),
                                    fit: BoxFit.cover)),
                            child: Column(
                              children: [
                                Text("${state.weather.name.toUpperCase()}"),
                                Text(
                                  "${(state.weather.main.temp - 273).toStringAsFixed(1)}",
                                  style: TextStyle(fontSize: 45),
                                ),
                              ],
                            ),
                          );
                        } else if (state is CurrentWeatherFailed) {
                          return Text("${state.message}");
                        } else {
                          return SizedBox.shrink();
                        }
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
