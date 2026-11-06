import 'package:json_annotation/json_annotation.dart';

part 'weather_request.g.dart';

/// `fetchWeather` に渡すリクエスト。
@JsonSerializable(createFactory: false)
class WeatherRequest {
  const WeatherRequest({required this.area, required this.date});

  final String area;
  final DateTime date;

  Map<String, Object?> toJson() => _$WeatherRequestToJson(this);
}
