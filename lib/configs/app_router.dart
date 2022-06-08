import 'package:flutter/material.dart';
import 'package:scroad_seller_flutter/screens/auctions/plate_number_screen.dart';
import 'package:scroad_seller_flutter/screens/guidance/guidance_screen.dart';
import 'package:scroad_seller_flutter/screens/home/home_screen.dart';
import 'package:scroad_seller_flutter/screens/settings/settings_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return HomeScreen.route();
      case PlateNumberScreen.routeName:
        return PlateNumberScreen.route();
      case SettingsScreen.routeName:
        return SettingsScreen.route();
      case GuidanceScreen.routeName:
        return GuidanceScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text('Error'),
        ),
      ),
      settings: const RouteSettings(name: '/error'),
    );
  }
}
