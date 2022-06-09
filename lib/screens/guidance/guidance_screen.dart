import 'package:flutter/material.dart';
import 'package:scroad_seller_flutter/extensions/hexadecimal_convert.dart';
import 'package:scroad_seller_flutter/widgets/custom_app_bar.dart';

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;

  static List<Item> items = [
    Item(
      headerValue: '수출차란',
      expandedValue:
          '폐차할까 생각하다가 우연히 수출을 알아보고 판매했네요 거래해주신분도 친절하시고 정말 좋은 가격에 거래한 것 같아 기분이 좋습니다 앞으로도 자주 이용할것같아요 감사합니다',
    ),
    Item(
      headerValue: '이용안내',
      expandedValue:
          '폐차할까 생각하다가 우연히 수출을 알아보고 판매했네요 거래해주신분도 친절하시고 정말 좋은 가격에 거래한 것 같아 기분이 좋습니다 앞으로도 자주 이용할것같아요 감사합니다',
    ),
    Item(
      headerValue: '감가정보',
      expandedValue:
          '폐차할까 생각하다가 우연히 수출을 알아보고 판매했네요 거래해주신분도 친절하시고 정말 좋은 가격에 거래한 것 같아 기분이 좋습니다 앞으로도 자주 이용할것같아요 감사합니다',
    ),
    Item(
      headerValue: '서류안내',
      expandedValue:
          '폐차할까 생각하다가 우연히 수출을 알아보고 판매했네요 거래해주신분도 친절하시고 정말 좋은 가격에 거래한 것 같아 기분이 좋습니다 앞으로도 자주 이용할것같아요 감사합니다',
    )
  ];
}

class GuidanceScreen extends StatefulWidget {
  static const String routeName = '/guidance';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const GuidanceScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const GuidanceScreen({Key? key}) : super(key: key);

  @override
  State<GuidanceScreen> createState() => _GuidanceScreenState();
}

class _GuidanceScreenState extends State<GuidanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Guidance',
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 30, bottom: 20),
              child: Text(
                'Guide',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: HexColor.fromHex('#c1c1c1'),
                    ),
              ),
            ),
            _buildPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        final currentItem = Item.items[index];
        setState(() {
          currentItem.isExpanded = !isExpanded;
          for (var item in Item.items) {
            if (item != currentItem) {
              item.isExpanded = false;
            }
          }
        });
      },
      children: Item.items.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                item.headerValue,
                style: Theme.of(context).textTheme.headline4,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
            );
          },
          body: ListTile(
            title: Text(item.expandedValue),
            contentPadding: const EdgeInsets.all(20.0),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
