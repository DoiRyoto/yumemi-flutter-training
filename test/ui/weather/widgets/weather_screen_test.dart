import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/repositories/weather_repository.dart';
import 'package:flutter_training/ui/weather/widgets/temperature_labels.dart';
import 'package:flutter_training/ui/weather/widgets/weather_panel.dart';
import 'package:flutter_training/ui/weather/widgets/weather_screen.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import '../../../helpers/fake_yumemi_weather.dart';

/// [results] は Reload をタップするたびに API が返すものを、順に並べる。
Future<void> _pumpWeatherScreen(
  WidgetTester tester, {
  Size? size,
  List<Object>? results,
}) async {
  if (size != null) {
    tester.view
      ..physicalSize = size
      ..devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
  }

  await tester.pumpWidget(
    MaterialApp(
      home: WeatherScreen(
        repository: WeatherRepository(
          client: FakeYumemiWeather(results ?? [weatherJson()]),
        ),
      ),
    ),
  );
}

/// 最低気温と最高気温のラベル。この順に並ぶ。
final Finder _temperatures = find.descendant(
  of: find.byType(TemperatureLabels),
  matching: find.byType(Text),
);

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
    expect(find.text('** ℃'), findsNWidgets(2));
  });

  testWidgets('Reload をタップすると天気の画像と気温を表示する', (tester) async {
    await _pumpWeatherScreen(
      tester,
      size: phone,
      results: [weatherJson(condition: 'cloudy', min: 3, max: 18)],
    );
    await _tapReload(tester);

    expect(find.byType(Placeholder), findsNothing);
    final image = tester.widget<SvgPicture>(find.byType(SvgPicture));
    expect(
      image.bytesLoader,
      isA<SvgAssetLoader>().having(
        (loader) => loader.assetName,
        'assetName',
        'assets/images/cloudy.svg',
      ),
    );
    expect(tester.widget<Text>(_temperatures.at(0)).data, '3 ℃');
    expect(tester.widget<Text>(_temperatures.at(1)).data, '18 ℃');
  });

  group('API のエラー', () {
    testWidgets('エラーになるとダイアログで理由を伝える', (tester) async {
      await _pumpWeatherScreen(
        tester,
        size: phone,
        results: [YumemiWeatherError.unknown],
      );
      await _tapReload(tester);

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('時間をおいて、もう一度お試しください。'), findsOneWidget);
    });

    testWidgets('エラーの種類に応じてメッセージを変える', (tester) async {
      await _pumpWeatherScreen(
        tester,
        size: phone,
        results: [YumemiWeatherError.invalidParameter],
      );
      await _tapReload(tester);

      expect(find.text('地域の指定が正しくありません。'), findsOneWidget);
    });

    testWidgets('OK をタップするとダイアログを閉じる', (tester) async {
      await _pumpWeatherScreen(
        tester,
        size: phone,
        results: [YumemiWeatherError.unknown],
      );
      await _tapReload(tester);

      await tester.tap(find.widgetWithText(TextButton, 'OK'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets('エラーになっても表示中の天気は残す', (tester) async {
      await _pumpWeatherScreen(
        tester,
        size: phone,
        results: [weatherJson(), YumemiWeatherError.unknown],
      );
      await _tapReload(tester);
      await _tapReload(tester);
      await tester.tap(find.widgetWithText(TextButton, 'OK'));
      await tester.pumpAndSettle();

      expect(find.byType(SvgPicture), findsOneWidget);
    });
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
        final minLabel = tester.getRect(_temperatures.at(0));
        final maxLabel = tester.getRect(_temperatures.at(1));
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
