import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/main.dart';
import 'package:flutter_training/ui/launch/widgets/launch_screen.dart';
import 'package:flutter_training/ui/weather/widgets/weather_screen.dart';

const _delay = Duration(milliseconds: 500);

Future<void> _launch(WidgetTester tester) async {
  tester.view
    ..physicalSize = const Size(393, 852)
    ..devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(const MainApp());
}

void main() {
  testWidgets('起動すると緑の画面から 0.5 秒後に天気予報の画面へ遷移する', (tester) async {
    await _launch(tester);

    final scaffold = tester.widget<Scaffold>(
      find.descendant(
        of: find.byType(LaunchScreen),
        matching: find.byType(Scaffold),
      ),
    );
    expect(scaffold.backgroundColor, Colors.green);

    await tester.pump(_delay - const Duration(milliseconds: 1));
    expect(find.byType(WeatherScreen), findsNothing, reason: '0.5 秒経つまでは遷移しない');

    await tester.pump(const Duration(milliseconds: 1));
    await tester.pumpAndSettle();
    expect(find.byType(WeatherScreen), findsOneWidget);
  });

  testWidgets('Close で閉じると緑の画面に戻り、0.5 秒後に再び遷移する', (tester) async {
    await _launch(tester);
    await tester.pump(_delay);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(TextButton, 'Close'));
    await tester.pump();
    // 戻るアニメーションを終わらせる。待ち時間は Close のタップから数えるので、0.5 秒は超えないようにする。
    await tester.pump(_delay - const Duration(milliseconds: 1));
    expect(find.byType(WeatherScreen), findsNothing);
    expect(find.byType(LaunchScreen), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1));
    await tester.pumpAndSettle();
    expect(find.byType(WeatherScreen), findsOneWidget);
  });
}
