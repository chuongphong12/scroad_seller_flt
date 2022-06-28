import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:scroad_seller_flutter/extensions/hexadecimal_convert.dart';
import 'package:scroad_seller_flutter/models/tab_item_model.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final ValueChanged<int>? onChangeIndex;
  const CustomBottomNavigationBar({Key? key, this.onChangeIndex})
      : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentTab = 0;
  final List<CustomTabItem> _tabItems = CustomTabItem.tabItems;
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      items: _tabItems.map((tab) {
        return TabItem(icon: tab.icon, title: tab.title);
      }).toList(),
      initialActiveIndex: _currentTab,
      backgroundColor: Colors.white24,
      color: HexColor.fromHex('c1c1c1'),
      activeColor: HexColor.fromHex('8691ff'),
      cornerRadius: 15,
      style: TabStyle.fixed,
      onTap: (int i) {
        setState(() {
          _currentTab = i;
        });
        widget.onChangeIndex!(i);
      },
    );
  }
}
