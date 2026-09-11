import 'package:flutter/material.dart';
import 'package:flutter_training/ui/weather/widgets/action_buttons.dart';
import 'package:flutter_training/ui/weather/widgets/weather_panel.dart';

/// 天気予報の画面。
class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              WeatherPanel(),
              ActionButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
