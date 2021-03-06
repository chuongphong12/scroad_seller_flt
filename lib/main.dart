import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroad_seller_flutter/blocs/auctions/auction_bloc.dart';
import 'package:scroad_seller_flutter/configs/app_router.dart';
import 'package:scroad_seller_flutter/configs/theme.dart';
import 'package:scroad_seller_flutter/firebase_options.dart';
import 'package:scroad_seller_flutter/screens/app.dart';
import 'package:scroad_seller_flutter/simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuctionBloc>(
          create: (context) => AuctionBloc()..add(InitializeAuction()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SCRoad Seller',
        theme: theme(),
        home: const AppScreen(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppScreen.routeName,
      ),
    );
  }
}
