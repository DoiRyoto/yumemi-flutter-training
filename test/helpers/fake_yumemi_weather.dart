import 'package:yumemi_weather/yumemi_weather.dart';

/// [YumemiWeather.fetchThrowsWeather] の結果を固定できる [YumemiWeather]。
///
/// コンストラクタに渡した結果を、先頭から順に返す。要素が [YumemiWeatherError] ならそれを投げる。
class FakeYumemiWeather extends YumemiWeather {
  FakeYumemiWeather(List<Object> results) : _results = [...results];

  final List<Object> _results;

  @override
  String fetchThrowsWeather(String area) {
    final result = _results.removeAt(0);
    if (result is YumemiWeatherError) {
      // 本物の API と同じく、Exception ではない YumemiWeatherError をそのまま投げる。
      // ignore: only_throw_errors
      throw result;
    }
    return result as String;
  }
}
