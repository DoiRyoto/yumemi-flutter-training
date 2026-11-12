import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/domain/models/weather_error.dart';

/// 天気の取得に失敗した理由を伝えるダイアログ。OK で閉じる。
class WeatherErrorDialog extends StatelessWidget {
  const WeatherErrorDialog({required this.error, super.key});

  final WeatherError error;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<WeatherError>('error', error));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('天気を取得できませんでした'),
      content: Text(switch (error) {
        WeatherError.invalidParameter => '地域の指定が正しくありません。',
        WeatherError.invalidResponse => '天気の情報を読み取れませんでした。',
        WeatherError.unknown => '時間をおいて、もう一度お試しください。',
      }),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
