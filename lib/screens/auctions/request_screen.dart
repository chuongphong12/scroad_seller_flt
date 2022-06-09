import 'package:flutter/material.dart';
import 'package:scroad_seller_flutter/extensions/hexadecimal_convert.dart';
import 'package:scroad_seller_flutter/widgets/custom_app_bar.dart';

class RequestScreen extends StatefulWidget {
  static const String routeName = '/request';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const RequestScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const RequestScreen({Key? key}) : super(key: key);

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '폭스바겐 아테온',
                style: Theme.of(context).textTheme.headline3,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '12가 1234',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: HexColor.fromHex('bababa')),
                  ),
                  SizedBox(
                    height: 25,
                    child: VerticalDivider(
                      color: HexColor.fromHex('bababa'),
                      thickness: 2,
                      indent: 5,
                      endIndent: 0,
                      width: 15,
                    ),
                  ),
                  Text(
                    '2015년',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: HexColor.fromHex('bababa')),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
