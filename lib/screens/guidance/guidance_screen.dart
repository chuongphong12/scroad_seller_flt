import 'package:flutter/material.dart';
import 'package:scroad_seller_flutter/widgets/custom_app_bar.dart';

class GuidanceScreen extends StatelessWidget {
  static const String routeName = '/guidance';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const GuidanceScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const GuidanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Guidance',
      ),
      body: Center(
        child: Text('Guidance'),
      ),
    );
  }
}
