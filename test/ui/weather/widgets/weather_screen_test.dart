import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/ui/weather/widgets/weather_panel.dart';
import 'package:flutter_training/ui/weather/widgets/weather_screen.dart';

Future<void> _pumpWeatherScreen(WidgetTester tester, {Size? size}) async {
  if (size != null) {
    tester.view
      ..physicalSize = size
      ..devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
  }

  await tester.pumpWidget(const MaterialApp(home: WeatherScreen()));
}

Future<void> _tapReload(WidgetTester tester) async {
  await tester.tap(find.widgetWithText(TextButton, 'Reload'));
  await tester.pump();
}

void main() {
  const phone = Size(393, 852);

  testWidgets('Reload をタップする前は Placeholder を表示する', (tester) async {
    await _pumpWeatherScreen(tester, size: phone);

    expect(find.byType(Placeholder), findsOneWidget);
    expect(find.byType(SvgPicture), findsNothing);
  });

  testWidgets('Reload をタップすると天気の画像を表示する', (tester) async {
    await _pumpWeatherScreen(tester, size: phone);
    await _tapReload(tester);

    expect(find.byType(Placeholder), findsNothing);
    expect(find.byType(SvgPicture), findsOneWidget);
  });

  group('天気の画像を表示してもレイアウトが崩れない', () {
    const sizes = {
      'スマートフォン': phone,
      '小型端末': Size(360, 640),
      'タブレット': Size(834, 1194),
    };

    for (final MapEntry(key: name, value: size) in sizes.entries) {
      testWidgets('$name (${size.width.toInt()}x${size.height.toInt()})', (
        tester,
      ) async {
        await _pumpWeatherScreen(tester, size: size);
        await _tapReload(tester);

        final panel = tester.getRect(find.byType(WeatherPanel));
        final image = tester.getRect(find.byType(AspectRatio));
        final minLabel = tester.getRect(find.text('** ℃').at(0));
        final maxLabel = tester.getRect(find.text('** ℃').at(1));
        final buttons = tester.getRect(
          find
              .ancestor(
                of: find.widgetWithText(TextButton, 'Close'),
                matching: find.byType(Row),
              )
              .first,
        );
        final close = tester.getRect(find.widgetWithText(TextButton, 'Close'));
        final reload = tester.getRect(
          find.widgetWithText(TextButton, 'Reload'),
        );

        expect(image.width, size.width / 2, reason: '画像の幅は画面の幅の半分');
        expect(image.height, image.width, reason: '画像は正方形');
        expect(minLabel.width, image.width / 2, reason: '気温ラベルの幅は画像の幅の半分');
        expect(image.center.dx, size.width / 2, reason: '画像は水平方向の中央');
        expect(
          panel.center.dy,
          size.height / 2,
          reason: '画像と気温ラベルを合わせた領域は垂直方向の中央',
        );
        expect(buttons.top - panel.bottom, 80, reason: '気温ラベルとボタンの隙間は 80');
        expect(close.center.dx, minLabel.center.dx, reason: 'Close は最低気温の真下');
        expect(reload.center.dx, maxLabel.center.dx, reason: 'Reload は最高気温の真下');
      });
    }
  });
}
