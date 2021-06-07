import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  final enterCity = find.byValueKey("Enter city");
  final button = find.byValueKey("button");
  final weather = find.byValueKey("weather condition");
  FlutterDriver driver;
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });
  tearDownAll(() async {
    if (driver != null) {
      await driver.close();
    }
  });
  test("Test for search city", () async {
    //  await driver.waitFor(enterCity);
    await driver.setTextEntryEmulation(enabled: true);
    await driver.tap(enterCity);
    await driver.enterText("Lagos");
    await driver.tap(button);
    var result = await driver.getText(weather);
    expect(result.startsWith("Weather"), "Weather condition: ");
  });
}
