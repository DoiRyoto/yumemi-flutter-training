import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/main.dart';
import 'package:flutter_training/ui/weather/widgets/weather_panel.dart';

Future<void> _run(WidgetTester tester, Size screen) async {
  tester.view
    ..physicalSize = screen
    ..devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(const MainApp());

  expect(find.byType(Placeholder), findsOneWidget);
  expect(find.byType(SvgPicture), findsNothing);

  await tester.tap(find.widgetWithText(TextButton, 'Reload'));
  await tester.pump();

  expect(find.byType(Placeholder), findsNothing, reason: 'タップが効く');
  expect(find.byType(SvgPicture), findsOneWidget);

  final panel = tester.getRect(find.byType(WeatherPanel));
  final square = tester.getRect(find.byType(AspectRatio));
  final blue = tester.getRect(find.text('** ℃').at(0));
  final red = tester.getRect(find.text('** ℃').at(1));
  final row = tester.getRect(find.ancestor(
    of: find.widgetWithText(TextButton, 'Close'),
    matching: find.byType(Row),
  ).first);
  final close = tester.getRect(find.widgetWithText(TextButton, 'Close'));
  final reload = tester.getRect(find.widgetWithText(TextButton, 'Reload'));

  expect(square.width / screen.width, 0.5, reason: '画面幅の半分');
  expect(square.width, square.height, reason: '正方形');
  expect(blue.width / square.width, 0.5, reason: 'Placeholder の半分');
  expect(square.center.dx, screen.width / 2, reason: '水平中央');
  expect(panel.center.dy, screen.height / 2, reason: 'ブロックの垂直中央');
  expect(row.top - panel.bottom, 80, reason: 'ボタンとの隙間');
  expect(close.center.dx, blue.center.dx, reason: 'Close と青字の中心');
  expect(reload.center.dx, red.center.dx, reason: 'Reload と赤字の中心');
}

void main() {
  testWidgets('iPhone 17  393x852', (t) => _run(t, const Size(393, 852)));
  testWidgets('小型端末   360x640', (t) => _run(t, const Size(360, 640)));
  testWidgets('タブレット 834x1194', (t) => _run(t, const Size(834, 1194)));
}
