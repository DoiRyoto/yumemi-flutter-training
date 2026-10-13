import 'package:flutter_training/routing/routes.dart';
import 'package:flutter_training/ui/launch/widgets/launch_screen.dart';
import 'package:flutter_training/ui/weather/widgets/weather_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.launch,
  routes: [
    GoRoute(
      path: Routes.launch,
      builder: (context, state) => const LaunchScreen(),
    ),
    GoRoute(
      path: Routes.weather,
      builder: (context, state) => const WeatherScreen(),
    ),
  ],
);
