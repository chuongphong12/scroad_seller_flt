import 'package:flutter/material.dart';
import 'package:scroad_seller_flutter/models/tab_item_model.dart';
import 'package:scroad_seller_flutter/widgets/custom_bottom_bar.dart';

class AppScreen extends StatefulWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const AppScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const AppScreen({Key? key}) : super(key: key);

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int _currentTab = 0;
  final List<CustomTabItem> _tabItems = CustomTabItem.tabItems;

  void changeIndex(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabItems[_currentTab].screen,
      bottomNavigationBar: CustomBottomNavigationBar(
        onChangeIndex: changeIndex,
      ),
    );
  }
}
