import 'package:flutter/material.dart';

/// 気温ラベルの 80 下に並ぶボタン。
///
/// 「天気表示と気温ラベルの矩形が画面中央」という要件のため、高さ 0 の
/// アンカーとして振る舞い、描画だけ下にはみ出させている。
class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0,
      child: OverflowBox(
        maxHeight: double.infinity,
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Close'),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Reload'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
