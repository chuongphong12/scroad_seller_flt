import 'package:flutter/material.dart';
import 'package:scroad_seller_flutter/widgets/custom_app_bar.dart';
import 'package:scroad_seller_flutter/widgets/custom_bottom_bar.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = '/settings';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const SettingsScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Settings',
      ),
      body: Center(
        child: Text('Settings'),
      ),
    );
  }
}
