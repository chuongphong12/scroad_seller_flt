import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:scroad_seller_flutter/blocs/auctions/auction_bloc.dart';
import 'package:scroad_seller_flutter/extensions/hexadecimal_convert.dart';
import 'package:scroad_seller_flutter/screens/auctions/request_screen.dart';
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
    final TextEditingController controller = TextEditingController();
    final ScrollController scrollController = ScrollController();

    double height = const CustomAppBar().preferredSize.height;

    final List plateDetailList = [
      {
        'title': '조회일자',
        'value': '2021.01.22',
      },
      {
        'title': '차량번호',
        'value': '2021.01.22',
      },
      {
        'title': '기준일자',
        'value': '2021.01.22',
      },
      {
        'title': '차명',
        'value': '2021.01.22',
      },
      {
        'title': '제조사',
        'value': '2021.01.22',
      },
      {
        'title': '용도',
        'value': '2021.01.22',
      },
      {
        'title': '배기량',
        'value': '2021.01.22',
      },
      {
        'title': '최초보험가입일',
        'value': '2021.01.22',
      },
      {
        'title': '사용연료',
        'value': '2021.01.22',
      },
      {
        'title': '차체형상',
        'value': '2021.01.22',
      },
      {
        'title': '자차피해사고횟수',
        'value': '2021.01.22',
      },
      {
        'title': '자차피해보험금합',
        'value': '2021.01.22',
      },
      {
        'title': '일반전손사고건수',
        'value': '2021.01.22',
      },
      {
        'title': '일반전손사고일수',
        'value': '2021.01.22',
      },
      {
        'title': '침수전(분)사고건수',
        'value': '2021.01.22',
      }
    ];

    void onSubmit() {
      if (controller.text.isNotEmpty) {
        context
            .read<AuctionBloc>()
            .add(AddPlateNumberEvent(plateNumber: controller.text));
        Navigator.of(context).pushNamed(RequestScreen.routeName);
      }
      if (controller.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).errorColor,
            content: const Text('Please enter a plate number'),
          ),
        );
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
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
                    Text('차량번호입력',
                        style: Theme.of(context).textTheme.headline4),
                    const SizedBox(height: 5),
                    Text(
                      '띄어쓰기 없이 입력해 주세요.',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: HexColor.fromHex('#b3b3b3'),
                          ),
                    ),
                    const Spacer(),
                    FormBuilderTextField(
                      name: 'plateNumber',
                      controller: controller,
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(),
                        ],
                      ),
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
                      onSubmitted: (String? value) {
                        onSubmit();
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          builder: (BuildContext context) =>
                              _buildSheet(context, plateDetailList),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  DraggableScrollableSheet _buildSheet(
      BuildContext context, List<dynamic> plateDetailList) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      minChildSize: 0.8,
      builder: (_, controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '12가 1234',
              style: Theme.of(context).textTheme.headline3,
            ),
            Divider(
              color: HexColor.fromHex('dfdfdf'),
              thickness: 1,
            ),
            Expanded(
              child: ListView.builder(
                controller: controller,
                shrinkWrap: true,
                itemCount: plateDetailList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          plateDetailList[index]['title'],
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                        trailing: Text(
                          plateDetailList[index]['value'],
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ),
                      Divider(
                        color: HexColor.fromHex('dfdfdf'),
                        thickness: 1,
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
