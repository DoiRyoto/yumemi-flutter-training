import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 最低気温と最高気温を左右に等分して並べる。未取得の気温は `**` で表す。
class TemperatureLabels extends StatelessWidget {
  const TemperatureLabels({this.min, this.max, super.key});

  /// 最低気温（℃）。
  final int? min;

  /// 最高気温（℃）。
  final int? max;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('min', min))
      ..add(IntProperty('max', max));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _Temperature(value: min, color: Colors.blue),
        ),
        Expanded(
          child: _Temperature(value: max, color: Colors.red),
        ),
      ],
    );
  }
}

class _Temperature extends StatelessWidget {
  const _Temperature({required this.value, required this.color});

  final int? value;
  final Color color;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('value', value))
      ..add(ColorProperty('color', color));
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${value ?? '**'} ℃',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(color: color),
    );
  }
}
