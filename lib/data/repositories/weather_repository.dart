import 'dart:convert';

import 'package:flutter_training/data/models/weather_request.dart';
import 'package:flutter_training/data/models/weather_response.dart';
import 'package:flutter_training/domain/models/weather.dart';
import 'package:flutter_training/domain/models/weather_error.dart';
import 'package:flutter_training/utils/result.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherRepository {
  WeatherRepository({YumemiWeather? client, DateTime Function()? now})
    : _client = client ?? YumemiWeather(),
      _now = now ?? DateTime.now;

  static const _area = 'tokyo';

  final YumemiWeather _client;
  final DateTime Function() _now;

  /// 今日の天気予報を取得する。
  Result<Weather, WeatherError> fetch() {
    final request = WeatherRequest(area: _area, date: _now());

    final String response;
    try {
      response = _client.fetchWeather(jsonEncode(request));
    } on YumemiWeatherError catch (error) {
      return Err(switch (error) {
        YumemiWeatherError.invalidParameter => WeatherError.invalidParameter,
        YumemiWeatherError.unknown => WeatherError.unknown,
      });
    }

    try {
      if (jsonDecode(response) case final Map<String, Object?> json) {
        return Ok(WeatherResponse.fromJson(json).toWeather());
      }
    } on FormatException {
      // JSON として読めない。
    } on CheckedFromJsonException {
      // JSON の形が想定と違う。
    }
    return const Err(WeatherError.invalidResponse);
  }
}
