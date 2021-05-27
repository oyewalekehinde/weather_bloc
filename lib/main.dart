import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc/bloc/current_weather/currentweather_bloc.dart';
import 'package:weather_bloc/pages/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentweatherBloc>(
      create: (context) => CurrentweatherBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: MyHomePage(title: 'Flutter Demo Home Page'),
        home: MainScreen(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CurrentweatherBloc _currentBloc = CurrentweatherBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Container(
              color: Colors.blue,
              child: TextFormField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                cursorColor: Colors.white54,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white54),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.25)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.25)),
                  fillColor: Theme.of(context).colorScheme.primaryVariant,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.white70,
                    size: 20,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   _obscureText = !_obscureText;
                      // });
                    },
                    child: Icon(
                      // _obscureText
                      //     ? Icons.visibility
                      //     :
                      Icons.visibility_off,
                      color: Colors.white70,
                      size: 20,
                    ),
                  ),
                ),
                validator: (input) => input.length < 6
                    ? 'password must be more than 6 characters'
                    : null,
                // onSaved: (input) => _password = input,
                // obscureText: _obscureText,
              ),
            ),
            BlocBuilder<CurrentweatherBloc, CurrentweatherState>(
                bloc: _currentBloc,
                builder: (context, state) {
                  if (state is CurrentWeatherLoading) {
                    return CircularProgressIndicator();
                  } else if (state is CurrentWeatherSuccess) {
                    return Text("${state.weather}");
                  } else if (state is CurrentWeatherFailed) {
                    return Text(state.message);
                  } else {
                    return Container();
                  }
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _currentBloc.add(CityNameEvent("lagos")),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
