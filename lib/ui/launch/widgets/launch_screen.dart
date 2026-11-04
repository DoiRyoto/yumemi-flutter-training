import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_training/routing/routes.dart';
import 'package:go_router/go_router.dart';

/// 起動時に表示する緑の画面。表示されてから 0.5 秒後に天気予報の画面へ遷移する。
///
/// 天気予報の画面が閉じられて戻ってきたときも、同様に再び遷移する。
class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  static const _delay = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    // 描画が始まってから待ち時間を数える。
    unawaited(WidgetsBinding.instance.endOfFrame.then((_) => _showWeather()));
  }

  Future<void> _showWeather() async {
    await Future<void>.delayed(_delay);
    if (!mounted) {
      return;
    }
    await context.push<void>(Routes.weather);
    if (!mounted) {
      return;
    }
    await _showWeather();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Colors.green);
  }
}
