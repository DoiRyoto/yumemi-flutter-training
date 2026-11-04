import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/domain/models/weather_condition.dart';
import 'package:flutter_training/ui/weather/widgets/temperature_labels.dart';

/// 正方形の天気表示と、その下の気温ラベル。
class WeatherPanel extends StatelessWidget {
  const WeatherPanel({required this.condition, super.key});

  final WeatherCondition? condition;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<WeatherCondition>('condition', condition));
  }

  @override
  Widget build(BuildContext context) {
    final condition = this.condition;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 1,
          // 未取得、または取得できなかったときは Placeholder を出す。
          child: condition == null
              ? const Placeholder()
              : SvgPicture.asset(condition.imagePath),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: TemperatureLabels(),
        ),
      ],
    );
  }
}
