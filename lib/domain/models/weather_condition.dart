/// 天気の状態。SVG のファイル名と対応する。
enum WeatherCondition {
  sunny,
  cloudy,
  rainy;

  /// API が返す文字列から復元する。未知の値なら null。
  static WeatherCondition? fromName(String name) => values.asNameMap()[name];

  String get imagePath => 'assets/images/$name.svg';
}
