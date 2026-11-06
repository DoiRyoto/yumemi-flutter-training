import 'dart:convert';

import 'package:yumemi_weather/yumemi_weather.dart';

/// [YumemiWeather.fetchWeather] の結果を固定できる [YumemiWeather]。
///
/// コンストラクタに渡した結果を、先頭から順に返す。要素が [YumemiWeatherError] ならそれを投げる。
class FakeYumemiWeather extends YumemiWeather {
  FakeYumemiWeather(List<Object> results) : _results = [...results];

  final List<Object> _results;

  /// 受け取ったリクエストの JSON 文字列。古い順。
  final List<String> requests = [];

  @override
  String fetchWeather(String jsonString) {
    requests.add(jsonString);
    final result = _results.removeAt(0);
    if (result is YumemiWeatherError) {
      // 本物の API と同じく、Exception ではない YumemiWeatherError をそのまま投げる。
      // ignore: only_throw_errors
      throw result;
    }
    return result as String;
  }
}

/// [YumemiWeather.fetchWeather] が返す形の JSON 文字列を作る。
String weatherJson({
  String condition = 'sunny',
  int min = 7,
  int max = 25,
}) => jsonEncode({
  'weather_condition': condition,
  'max_temperature': max,
  'min_temperature': min,
  'date': '2020-04-01T12:00:00+09:00',
});
