import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroad_seller_flutter/blocs/auctions/auction_bloc.dart';
import 'package:scroad_seller_flutter/widgets/custom_app_bar.dart';

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
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Ongoing',
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<AuctionBloc, AuctionState>(
          bloc: AuctionBloc(),
          builder: (context, state) {
            if (state is AuctionLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is AuctionLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final auction = state.auctions[index];
                  return Card(
                    child: Column(
                      children: [
                        Image.file(auction.images[0].imageFile),
                        Text(auction.plateNumber),
                        Text(auction.sellerName),
                        Text(auction.sellerPhoneNumber),
                      ],
                    ),
                  );
                },
                itemCount: state.auctions.length,
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
}
