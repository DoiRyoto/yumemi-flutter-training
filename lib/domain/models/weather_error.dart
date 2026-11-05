/// 天気の取得に失敗した理由。
enum WeatherError implements Exception {
  /// リクエストの内容が正しくない。
  invalidParameter,

  /// 原因の分からない失敗。
  unknown,
}
