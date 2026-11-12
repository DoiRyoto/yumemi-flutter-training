import 'package:flutter_training/domain/models/weather_condition.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather.freezed.dart';

/// 天気予報。
@freezed
abstract class Weather with _$Weather {
  const factory Weather({
    required WeatherCondition condition,

    /// 最低気温（℃）。
    required int minTemperature,

    /// 最高気温（℃）。
    required int maxTemperature,
  }) = _Weather;
}
