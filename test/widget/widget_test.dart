import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_bloc/pages/main_screen.dart';

void main() {
  testWidgets("Testing for the textinput", (WidgetTester tester) async {
    //find all the widget needed
    final typeCity = find.byKey(ValueKey("Enter city"));

    //execute the actual test
    await tester.pumpWidget(MaterialApp(
      home: MainScreen(),
    ));
    await tester.enterText(typeCity, "paris");
    await tester.pump();

    //check for outputs
    expect(find.text("paris"), findsOneWidget);
  });
}
