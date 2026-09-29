import 'package:flutter/material.dart';
import 'package:flutter_training/ui/weather/widgets/temperature_labels.dart';

/// 正方形の天気表示と、その下の気温ラベル。
class WeatherPanel extends StatelessWidget {
  const WeatherPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(aspectRatio: 1, child: Placeholder()),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: TemperatureLabels(),
        ),
      ],
    );
  }
}
