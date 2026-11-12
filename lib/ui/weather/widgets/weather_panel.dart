import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/domain/models/weather.dart';
import 'package:flutter_training/ui/weather/widgets/temperature_labels.dart';

/// 正方形の天気表示と、その下の気温ラベル。
class WeatherPanel extends StatelessWidget {
  const WeatherPanel({required this.weather, super.key});

  /// 表示する天気予報。未取得なら null。
  final Weather? weather;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Weather>('weather', weather));
  }

  @override
  Widget build(BuildContext context) {
    final weather = this.weather;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 1,
          // 未取得のときは Placeholder を出す。
          child: weather == null
              ? const Placeholder()
              : SvgPicture.asset(weather.condition.imagePath),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: TemperatureLabels(
            min: weather?.minTemperature,
            max: weather?.maxTemperature,
          ),
        ),
      ],
    );
  }
}
