import 'package:flutter/material.dart';
import 'package:flutter_training/data/repositories/weather_repository.dart';
import 'package:flutter_training/domain/models/weather_condition.dart';
import 'package:flutter_training/ui/weather/widgets/action_buttons.dart';
import 'package:flutter_training/ui/weather/widgets/weather_panel.dart';

/// 天気予報の画面。
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _repository = WeatherRepository();
  WeatherCondition? _condition;

  void _reload() {
    setState(() => _condition = _repository.fetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomMultiChildLayout(
        delegate: _WeatherLayoutDelegate(),
        children: [
          LayoutId(
            id: _Slot.panel,
            child: WeatherPanel(condition: _condition),
          ),
          LayoutId(
            id: _Slot.buttons,
            child: ActionButtons(onReload: _reload),
          ),
        ],
      ),
    );
  }
}

enum _Slot { panel, buttons }

/// パネルを画面中央に置き、ボタンをその [_gap] 下に並べる。
///
/// ボタンの高さはパネルの中央揃えに影響しない。両者を別々に配置するため、
/// [Column] の高さ計算に相乗りさせない。
class _WeatherLayoutDelegate extends MultiChildLayoutDelegate {
  static const _widthFactor = 0.5;
  static const _gap = 80.0;

  @override
  void performLayout(Size size) {
    final width = size.width * _widthFactor;

    final panel = layoutChild(
      _Slot.panel,
      BoxConstraints.tightFor(width: width).copyWith(maxHeight: size.height),
    );
    final origin = Offset(
      (size.width - width) / 2,
      (size.height - panel.height) / 2,
    );
    positionChild(_Slot.panel, origin);

    layoutChild(_Slot.buttons, BoxConstraints.tightFor(width: width));
    positionChild(
      _Slot.buttons,
      Offset(origin.dx, origin.dy + panel.height + _gap),
    );
  }

  @override
  bool shouldRelayout(_WeatherLayoutDelegate oldDelegate) => false;
}
