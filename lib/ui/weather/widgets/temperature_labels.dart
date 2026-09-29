import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 最低気温と最高気温を左右に等分して並べる。
class TemperatureLabels extends StatelessWidget {
  const TemperatureLabels({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: _Temperature(color: Colors.blue)),
        Expanded(child: _Temperature(color: Colors.red)),
      ],
    );
  }
}

class _Temperature extends StatelessWidget {
  const _Temperature({required this.color});

  final Color color;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('color', color));
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '** ℃',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(color: color),
    );
  }
}
