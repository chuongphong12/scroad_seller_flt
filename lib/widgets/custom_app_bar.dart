import 'package:flutter/material.dart';
import 'package:scroad_seller_flutter/screens/auctions/request_screen.dart';
import 'package:scroad_seller_flutter/screens/guidance/guidance_screen.dart';
import 'package:scroad_seller_flutter/screens/home/home_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String pushNavigator;
  const CustomAppBar({Key? key, this.title = 'Suchullo', this.pushNavigator = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const matchGuidanceRoute = GuidanceScreen.routeName;
    final currentRoute = ModalRoute.of(context)?.settings.name;
    return AppBar(
      elevation: 0,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline2,
      ),
      leading: (pushNavigator != '')
          ? BackButton(onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, pushNavigator, (Route<dynamic> route) => false);
            })
          : null,
      actions: currentRoute != matchGuidanceRoute
          ? [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, GuidanceScreen.routeName);
                },
                icon: const Icon(
                  Icons.info_outline,
                  color: Colors.black,
                ),
              ),
            ]
          : [],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(55);
}
