import 'package:flutter/widgets.dart';

/// 最初のレイアウトが表示された後に [afterLayout] を呼び出す。
mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        afterLayout();
      }
    });
  }

  /// 最初のレイアウトが表示された後に呼び出される。
  void afterLayout();
}
