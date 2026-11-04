import 'package:flutter_training/domain/models/weather_condition.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherRepository {
  WeatherRepository({YumemiWeather? client})
      : _client = client ?? YumemiWeather();

  final YumemiWeather _client;

  WeatherCondition? fetch() =>
      WeatherCondition.fromName(_client.fetchSimpleWeather());
}
