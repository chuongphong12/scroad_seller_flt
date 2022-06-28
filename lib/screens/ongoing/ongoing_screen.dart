import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroad_seller_flutter/blocs/auctions/auction_bloc.dart';
import 'package:scroad_seller_flutter/extensions/hexadecimal_convert.dart';
import 'package:scroad_seller_flutter/models/auction_model.dart';
import 'package:scroad_seller_flutter/widgets/custom_app_bar.dart';
import 'package:scroad_seller_flutter/widgets/custom_bottom_bar.dart';

class OngoingScreen extends StatelessWidget {
  static const String routeName = '/ongoing';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const OngoingScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const OngoingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<dynamic> status = [
      {'text': '기다려주세요', 'color': 'fec107'},
      {'text': '상태를 눌러 다음 단계를 진행해 주세요 ', 'color': '27a844'},
      {'text': '거래가 종료되었습니다', 'color': '6c757e'}
    ];
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Ongoing',
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<AuctionBloc, AuctionState>(
          builder: (context, state) {
            if (state is AuctionLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is AuctionLoaded) {
              return Padding(
                padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
                child: Column(
                  children: [
                    _buildStatus(context, status),
                    const SizedBox(height: 35),
                    OngoingCard(listOngoing: state.auctions),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('No requests'),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildStatus(BuildContext context, List status) {
    return Column(
      children: status.map((val) {
        return Row(
          children: [
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: HexColor.fromHex(val['color']),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              val['text'],
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: HexColor.fromHex(val['color']),
                  ),
            )
          ],
        );
      }).toList(),
    );
  }
}

class OngoingCard extends StatelessWidget {
  final List<AuctionModel> listOngoing;
  const OngoingCard({
    Key? key,
    required this.listOngoing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final auction = listOngoing[index];
        return InkWell(
          onTap: () {},
          child: Card(
            elevation: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.file(
                  auction.images[0].imageFile,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 25,
                        decoration: BoxDecoration(
                          color: HexColor.fromHex('fec107'),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '견적 진행 중 입니다 ',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 5,
                        ),
                        color: HexColor.fromHex('f9f8f5'),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              auction.plateNumber,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            const SizedBox(height: 3),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '12가 1234',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(
                                        fontSize: 10,
                                        color: HexColor.fromHex('bababa'),
                                      ),
                                ),
                                SizedBox(
                                  height: 18,
                                  child: VerticalDivider(
                                    color: HexColor.fromHex('bababa'),
                                    thickness: 2,
                                    indent: 2,
                                    endIndent: 0,
                                    width: 10,
                                  ),
                                ),
                                Text(
                                  '2015년',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(
                                        fontSize: 10,
                                        color: HexColor.fromHex('bababa'),
                                      ),
                                ),
                                SizedBox(
                                  height: 18,
                                  child: VerticalDivider(
                                    color: HexColor.fromHex('bababa'),
                                    thickness: 2,
                                    indent: 2,
                                    endIndent: 0,
                                    width: 10,
                                  ),
                                ),
                                Text(
                                  '185,323Km',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(
                                        fontSize: 10,
                                        color: HexColor.fromHex('bababa'),
                                      ),
                                )
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '최고가 : 2,500,000원',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: listOngoing.length,
    );
  }
}
