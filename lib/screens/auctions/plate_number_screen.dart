import 'package:flutter/material.dart';
import 'package:scroad_seller_flutter/extensions/hexadecimal_convert.dart';
import 'package:scroad_seller_flutter/widgets/custom_app_bar.dart';

class PlateNumberScreen extends StatelessWidget {
  static const String routeName = '/plate-number';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const PlateNumberScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const PlateNumberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = const CustomAppBar().preferredSize.height;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: const CustomAppBar(),
      body: Center(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.3 - height,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 34, bottom: 40, left: 21, right: 21),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('차량번호입력', style: Theme.of(context).textTheme.headline4),
                  const SizedBox(height: 5),
                  Text(
                    '띄어쓰기 없이 입력해 주세요.',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: HexColor.fromHex('#b3b3b3'),
                        ),
                  ),
                  const Spacer(),
                  TextFormField(
                    decoration: InputDecoration(
                      constraints: const BoxConstraints.tightFor(height: 40),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          color: HexColor.fromHex('#ce9b00'),
                        ),
                      ),
                      labelText: '12가1234',
                      labelStyle: TextStyle(
                        color: HexColor.fromHex('#b5b5b5'),
                        fontSize: 14,
                      ),
                      suffixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
