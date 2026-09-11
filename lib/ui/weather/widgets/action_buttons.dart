import 'package:flutter/material.dart';

/// 天気の再取得などを行うボタン列。配置は親のレイアウトが決める。
class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
