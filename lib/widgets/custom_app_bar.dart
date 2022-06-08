import 'package:flutter/material.dart';
import 'package:scroad_seller_flutter/screens/guidance/guidance_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({Key? key, this.title = 'Suchullo'}) : super(key: key);

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
