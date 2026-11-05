import 'package:flutter_training/domain/models/weather_condition.dart';
import 'package:flutter_training/domain/models/weather_error.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherRepository {
  WeatherRepository({YumemiWeather? client})
      : _client = client ?? YumemiWeather();

  static const _area = 'tokyo';

  final YumemiWeather _client;

  /// 天気を取得する。失敗したときは [WeatherError] を投げる。
  WeatherCondition? fetch() {
    try {
      return WeatherCondition.fromName(_client.fetchThrowsWeather(_area));
    } on YumemiWeatherError catch (error) {
      throw switch (error) {
        YumemiWeatherError.invalidParameter => WeatherError.invalidParameter,
        YumemiWeatherError.unknown => WeatherError.unknown,
      };
    }
  }
}
