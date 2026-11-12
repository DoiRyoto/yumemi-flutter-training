/// 天気の状態。SVG のファイル名と対応する。
enum WeatherCondition {
  sunny,
  cloudy,
  rainy;

  String get imagePath => 'assets/images/$name.svg';
}
