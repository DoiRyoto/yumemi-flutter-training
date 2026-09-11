import 'package:flutter_training/domain/models/weather_condition.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

/// 天気予報の取得口。[YumemiWeather] を隠蔽する。
class WeatherRepository {
  WeatherRepository({YumemiWeather? client})
      : _client = client ?? YumemiWeather();

  final YumemiWeather _client;

  /// 天気を取得する。未知の値が返った場合は null。
  WeatherCondition? fetch() =>
      WeatherCondition.fromName(_client.fetchSimpleWeather());
}
