import 'package:flutter/material.dart';
import 'package:scroad_seller_flutter/screens/home/home_screen.dart';
import 'package:scroad_seller_flutter/screens/ongoing/ongoing_screen.dart';
import 'package:scroad_seller_flutter/screens/settings/settings_screen.dart';

class CustomTabItem {
  IconData icon;
  String title;
  Widget screen;

  CustomTabItem({
    required this.icon,
    required this.title,
    required this.screen,
  });

  static final tabItems = [
    CustomTabItem(
      icon: Icons.home,
      title: 'Home',
      screen: const HomeScreen(),
    ),
    CustomTabItem(
      icon: Icons.swap_vertical_circle,
      title: 'Ongoing',
      screen: const OngoingScreen(),
    ),
    CustomTabItem(
      icon: Icons.settings,
      title: 'Settings',
      screen: const SettingsScreen(),
    ),
  ];
}
