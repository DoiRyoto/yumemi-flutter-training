import 'package:flutter_training/domain/models/weather.dart';
import 'package:flutter_training/domain/models/weather_condition.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_response.g.dart';

/// `fetchWeather` が返すレスポンス。
@JsonSerializable(createToJson: false)
class WeatherResponse {
  const WeatherResponse({
    required this.weatherCondition,
    required this.maxTemperature,
    required this.minTemperature,
  });

  /// 形が想定と違えば [CheckedFromJsonException] を投げる。
  factory WeatherResponse.fromJson(Map<String, Object?> json) =>
      _$WeatherResponseFromJson(json);

  final WeatherCondition weatherCondition;
  final int maxTemperature;
  final int minTemperature;

  Weather toWeather() => Weather(
    condition: weatherCondition,
    minTemperature: minTemperature,
    maxTemperature: maxTemperature,
  );
}
