import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scroad_seller_flutter/blocs/auctions/auction_bloc.dart';
import 'package:scroad_seller_flutter/extensions/hexadecimal_convert.dart';
import 'package:scroad_seller_flutter/screens/home/home_screen.dart';
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
  final ImagePicker _imagePicker = ImagePicker();
  File? image;

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
  }

  Future _getImage(ImageSource source) async {
    final selectedImage = await _imagePicker.pickImage(source: source);
    if (image == null) {
      return;
    }
    final tempImage = File(selectedImage!.path);
    setState(() {
      image = File(selectedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(pushNavigator: HomeScreen.routeName),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  '폭스바겐 아테온',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocBuilder<AuctionBloc, AuctionState>(
                      builder: (context, state) {
                        if (state is AuctionLoading) {
                          return const CircularProgressIndicator();
                        }
                        if (state is AuctionLoaded) {
                          return Text(
                            state.auction.plateNumber,
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: HexColor.fromHex('bababa'),
                                    ),
                          );
                        }
                        return Text(
                          '12가 1234',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: HexColor.fromHex('bababa'),
                                  ),
                        );
                      },
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
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      _getImage(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Open Gallery',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      _getImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Open Camera',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Close',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20)),
                          color: HexColor.fromHex('#e3e3e3'),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              child: Image.asset(
                                'assets/images/mountain.png',
                                fit: BoxFit.contain,
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Divider(
                color: HexColor.fromHex('dfdfdf'),
                thickness: 1,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 29),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '사진을 최소 4장 이상 등록해주세요!',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: HexColor.fromHex('bababa'), fontSize: 13),
                    ),
                    Text(
                      '여러 각도의 디테일한 사진을 업로드 하시면 더욱 더 정확한 견적금액을 받으실 수 있습니다',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: HexColor.fromHex('ff8b8b'), fontSize: 13),
                    ),
                  ],
                ),
              ),
              Divider(
                color: HexColor.fromHex('dfdfdf'),
                thickness: 1,
              ),
              const SizedBox(height: 40),
              FormBuilder(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      FormBuilderTextField(
                        name: 'name',
                        decoration: InputDecoration(
                          labelText: '판매자',
                          hintText: '(필수)',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onChanged: (String? newValue) {},
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                          ],
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 20),
                      FormBuilderTextField(
                        name: 'phoneNumber',
                        decoration: InputDecoration(
                          labelText: '전화번호',
                          hintText: '(필수)',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onChanged: (String? newValue) {},
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.numeric()
                          ],
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      FormBuilderTextField(
                        name: 'address',
                        decoration: InputDecoration(
                          labelText: '지역',
                          hintText: '(필수)',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onChanged: (String? newValue) {},
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.numeric()
                          ],
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      FormBuilderDropdown(
                        name: 'province',
                        items: List.generate(
                          20,
                          (index) {
                            return DropdownMenuItem(
                              value: index,
                              child: Text('$index'),
                            );
                          },
                        ),
                        decoration: InputDecoration(
                          labelText: '시군구',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: '(필수)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      FormBuilderDropdown(
                        name: 'district',
                        items: List.generate(
                          20,
                          (index) {
                            return DropdownMenuItem(
                              value: index,
                              child: Text('$index'),
                            );
                          },
                        ),
                        decoration: InputDecoration(
                          labelText: '주행거리',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: '(필수)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      FormBuilderDropdown(
                        name: 'district',
                        items: List.generate(
                          20,
                          (index) {
                            return DropdownMenuItem(
                              value: index,
                              child: Text('$index'),
                            );
                          },
                        ),
                        decoration: InputDecoration(
                          labelText: '주행거리',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: '(필수)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
