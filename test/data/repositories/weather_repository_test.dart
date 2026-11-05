import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/repositories/weather_repository.dart';
import 'package:flutter_training/domain/models/weather_condition.dart';
import 'package:flutter_training/domain/models/weather_error.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import '../../helpers/fake_yumemi_weather.dart';

void main() {
  test('API が返した天気を WeatherCondition にして返す', () {
    final repository = WeatherRepository(
      client: FakeYumemiWeather(['rainy']),
    );

    expect(repository.fetch(), WeatherCondition.rainy);
  });

  group('API のエラーを WeatherError に置き換えて投げる', () {
    const cases = {
      YumemiWeatherError.invalidParameter: WeatherError.invalidParameter,
      YumemiWeatherError.unknown: WeatherError.unknown,
    };

    for (final MapEntry(key: apiError, value: error) in cases.entries) {
      test(apiError.name, () {
        final repository = WeatherRepository(
          client: FakeYumemiWeather([apiError]),
        );

        expect(repository.fetch, throwsA(error));
      });
    }
  });
}
