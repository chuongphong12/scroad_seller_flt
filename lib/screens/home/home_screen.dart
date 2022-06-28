import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:scroad_seller_flutter/extensions/hexadecimal_convert.dart';
import 'package:scroad_seller_flutter/screens/auctions/plate_number_screen.dart';
import 'package:scroad_seller_flutter/widgets/custom_app_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const HomeScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController controller = CarouselController();
  int currentPos = 0;
  List<String> images = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTIZccfNPnqalhrWev-Xo7uBhkor57_rKbkw&usqp=CAU",
    "https://wallpaperaccess.com/full/2637581.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Column(
              children: [
                _buildAvailableCarCheck(context),
                const SizedBox(height: 20),
                _buildRequestCard(context),
                const SizedBox(height: 20),
                _buildHomeSlide(context),
                const SizedBox(height: 20),
                _buildReviewCardGrid(context, images),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHomeSlide(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
          carouselController: controller,
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index, int pageViewIndex) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                images[index],
                fit: BoxFit.cover,
              ),
            );
          },
          options: CarouselOptions(
            height: 200,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: (int index, CarouselPageChangedReason reason) {
              setState(() => currentPos = index);
            },
          ),
        ),
        Positioned(
          bottom: 5,
          left: MediaQuery.of(context).size.width * 0.5 - 30,
          child: AnimatedSmoothIndicator(
            activeIndex: currentPos,
            count: images.length,
            effect: const WormEffect(
              dotHeight: 10,
              dotWidth: 10,
              // strokeWidth: 5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRequestCard(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: HexColor.fromHex('#f3bb71'),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 30,
              left: 27,
              right: 27,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '비교견적으로',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  '내 차  비싸게',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                Text(
                  '팔아보자',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, PlateNumberScreen.routeName);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '내 차 견적의뢰',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(right: 30),
            child: Image.asset('assets/images/mail-box.png', width: 120),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableCarCheck(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: HexColor.fromHex('#9cb4f0'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(height: 40),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                labelText: '차종을 입력하세요',
                labelStyle: TextStyle(
                  color: HexColor.fromHex('#b5b5b5'),
                  fontSize: 14,
                ),
                suffixIcon: const Icon(Icons.search),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
              ),
              cursorHeight: 16,
            ),
          ),
          const SizedBox(height: 15),
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(height: 40),
            child: DropdownButtonFormField(
              isExpanded: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                labelText: '년식을 선택하세요',
                labelStyle: TextStyle(
                  color: HexColor.fromHex('#b5b5b5'),
                  fontSize: 14,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
              ),
              items: <String>['One', 'Two', 'Free', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {},
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '내 차 수출차 확인',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 12,
                  color: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildReviewCardGrid(BuildContext context, List<String> images) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      children: images.map((e) {
        return Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: HexColor.fromHex('#f3bb71'),
          ),
          child: Image.network(
            e,
            fit: BoxFit.cover,
          ),
        );
      }).toList(),
    );
  }
}
