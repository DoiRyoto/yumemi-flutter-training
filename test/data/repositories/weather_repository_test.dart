import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/repositories/weather_repository.dart';
import 'package:flutter_training/domain/models/weather.dart';
import 'package:flutter_training/domain/models/weather_condition.dart';
import 'package:flutter_training/domain/models/weather_error.dart';
import 'package:flutter_training/utils/result.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import '../../helpers/fake_yumemi_weather.dart';

Matcher _isErr(WeatherError error) => isA<Err<Weather, WeatherError>>().having(
  (result) => result.error,
  'error',
  error,
);

void main() {
  test('地域と日時を JSON にして API に渡す', () {
    final client = FakeYumemiWeather([weatherJson()]);
    final now = DateTime(2020, 4, 1, 12);
    WeatherRepository(client: client, now: () => now).fetch();

    expect(jsonDecode(client.requests.single), {
      'area': 'tokyo',
      'date': now.toIso8601String(),
    });
  });

  test('API が返した JSON を Weather にして返す', () {
    final repository = WeatherRepository(
      client: FakeYumemiWeather([
        weatherJson(condition: 'rainy', min: -3, max: 12),
      ]),
    );

    expect(
      repository.fetch(),
      isA<Ok<Weather, WeatherError>>().having(
        (result) => result.value,
        'value',
        const Weather(
          condition: WeatherCondition.rainy,
          minTemperature: -3,
          maxTemperature: 12,
        ),
      ),
    );
  });

  group('API のエラーを WeatherError に置き換えて返す', () {
    const cases = {
      YumemiWeatherError.invalidParameter: WeatherError.invalidParameter,
      YumemiWeatherError.unknown: WeatherError.unknown,
    };

    for (final MapEntry(key: apiError, value: error) in cases.entries) {
      test(apiError.name, () {
        final repository = WeatherRepository(
          client: FakeYumemiWeather([apiError]),
        );

        expect(repository.fetch(), _isErr(error));
      });
    }
  });

  group('読み取れないレスポンスは invalidResponse を返す', () {
    final cases = {
      'JSON ではない': 'sunny',
      'オブジェクトではない': '[]',
      '知らない天気': weatherJson(condition: 'snowy'),
      '気温が数値ではない': jsonEncode({
        'weather_condition': 'sunny',
        'max_temperature': '25',
        'min_temperature': 7,
      }),
      '気温がない': jsonEncode({'weather_condition': 'sunny'}),
    };

    for (final MapEntry(key: name, value: response) in cases.entries) {
      test(name, () {
        final repository = WeatherRepository(
          client: FakeYumemiWeather([response]),
        );

        expect(repository.fetch(), _isErr(WeatherError.invalidResponse));
      });
    }
  });
}
