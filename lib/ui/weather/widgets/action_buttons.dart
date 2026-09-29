import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 天気の再取得などを行うボタン列。配置は親のレイアウトが決める。
class ActionButtons extends StatelessWidget {
  const ActionButtons({required this.onReload, super.key});

  final VoidCallback onReload;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<VoidCallback>.has('onReload', onReload));
  }

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
            onPressed: onReload,
            child: const Text('Reload'),
          ),
        ),
      ],
    );
  }
}
