import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:heic_to_jpg/heic_to_jpg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:scroad_seller_flutter/blocs/auctions/auction_bloc.dart';
import 'package:scroad_seller_flutter/extensions/hexadecimal_convert.dart';
import 'package:scroad_seller_flutter/models/auction_model.dart';
import 'package:scroad_seller_flutter/screens/home/home_screen.dart';
import 'package:scroad_seller_flutter/screens/ongoing/ongoing_screen.dart';
import 'package:scroad_seller_flutter/widgets/custom_app_bar.dart';

class SelectedImage {
  final String side;
  final String sideText;
  File? file;

  SelectedImage({
    required this.side,
    required this.sideText,
    this.file,
  });
}

class RequestScreen extends StatefulWidget {
  static const String routeName = '/request';

  static Route route(Map arguments) {
    return MaterialPageRoute(
      builder: (context) => const RequestScreen(),
      settings: RouteSettings(name: routeName, arguments: arguments),
    );
  }

  const RequestScreen({Key? key}) : super(key: key);

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  File? frontImage;
  File? backImage;
  File? leftImage;
  File? rightImage;

  final List<SelectedImage> vehicleTexts = [
    SelectedImage(
      side: 'front',
      sideText: '정면(필수)',
    ),
    SelectedImage(
      sideText: '후면(필수)',
      side: 'back',
    ),
    SelectedImage(
      sideText: '좌측(필수)',
      side: 'left',
    ),
    SelectedImage(
      sideText: '우측(필수)',
      side: 'right',
    ),
  ];

  final List<File> listImage = [];

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
  }

  Future _addImageOnClick(ImageSource source, String side) async {
    File tempImage;
    final selectedImage = await _imagePicker.pickImage(source: source);
    if (selectedImage == null) {
      return;
    }
    String fileExtension = p.extension(selectedImage.path).replaceAll('.', '');
    if (fileExtension == 'heic') {
      print('convert to jpeg');
      String jpegPath = await HeicToJpg.convert(selectedImage.path) as String;
      tempImage = File(jpegPath);
    } else {
      tempImage = File(selectedImage.path);
    }
    switch (side) {
      case 'front':
        var index = 0;

        if (listImage.contains(vehicleTexts[index].file)) {
          setState(() {
            frontImage = tempImage;
            vehicleTexts[index].file = frontImage;
            listImage.replaceRange(index, index + 1, [frontImage!]);
          });
        } else {
          setState(() {
            frontImage = tempImage;
            vehicleTexts[index].file = frontImage;
            listImage.add(frontImage!);
          });
        }
        break;
      case 'back':
        var index = 1;
        if (listImage.contains(vehicleTexts[index].file)) {
          setState(() {
            backImage = tempImage;
            vehicleTexts[index].file = backImage;
            listImage.replaceRange(index, index + 1, [backImage!]);
          });
        } else {
          setState(() {
            backImage = tempImage;
            vehicleTexts[index].file = backImage;
            listImage.add(backImage!);
          });
        }
        break;
      case 'left':
        var index = 2;
        if (listImage.contains(vehicleTexts[index].file)) {
          setState(() {
            leftImage = tempImage;
            vehicleTexts[index].file = leftImage;
            listImage.replaceRange(index, index + 1, [leftImage!]);
          });
        } else {
          setState(() {
            leftImage = tempImage;
            vehicleTexts[index].file = leftImage;
            listImage.add(leftImage!);
          });
        }
        break;
      case 'right':
        var index = 3;
        if (listImage.contains(vehicleTexts[index].file)) {
          setState(() {
            rightImage = tempImage;
            vehicleTexts[index].file = rightImage;
            listImage.replaceRange(index, index + 1, [rightImage!]);
          });
        } else {
          setState(() {
            rightImage = tempImage;
            vehicleTexts[index].file = rightImage;
            listImage.add(rightImage!);
          });
        }
        break;
    }
  }

  List<UploadImage> _addUploadFileImage(List<File> images) {
    var uploadImage = <UploadImage>[];
    for (var image in images) {
      final tempImage = File(image.path);
      uploadImage.add(UploadImage(
        imageFile: tempImage,
        imageName: tempImage.path.split('/').last,
      ));
    }
    return uploadImage;
  }

  void _onSubmit(String plateNumber) {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      context.read<AuctionBloc>().add(
            AddAuction(
              auction: AuctionModel(
                auctionStatus: 'request',
                description:
                    _formKey.currentState!.value['description'] as String,
                images: _addUploadFileImage(listImage),
                sellerAddress:
                    _formKey.currentState!.value['address'] as String,
                sellerCity: _formKey.currentState!.value['province'].toString(),
                sellerName: _formKey.currentState!.value['name'] as String,
                sellerPhoneNumber:
                    _formKey.currentState!.value['phoneNumber'].toString(),
                plateNumber: plateNumber,
              ),
            ),
          );
      Navigator.of(context).pushReplacement(OngoingScreen.route());
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Map argument = ModalRoute.of(context)?.settings.arguments as Map;
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
                            argument['plateNumber'],
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
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: vehicleTexts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return BlocBuilder<AuctionBloc, AuctionState>(
                      builder: (context, state) {
                        if (state is AuctionLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (state is AuctionLoaded) {
                          return GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () async {
                                            _addImageOnClick(
                                                ImageSource.gallery,
                                                vehicleTexts[index].side);
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
                                            _addImageOnClick(ImageSource.camera,
                                                vehicleTexts[index].side);
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
                            child: vehicleTexts[index].file != null
                                ? ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                    ),
                                    child: FocusedMenuHolder(
                                      menuWidth:
                                          MediaQuery.of(context).size.width *
                                              0.3,
                                      blurSize: 5.0,
                                      menuItemExtent: 45,
                                      menuBoxDecoration: const BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                      ),
                                      duration: const Duration(
                                        milliseconds: 100,
                                      ),
                                      animateMenuItems: true,
                                      blurBackgroundColor: Colors.black54,
                                      bottomOffsetHeight: 200,
                                      menuOffset: 10,
                                      menuItems: <FocusedMenuItem>[
                                        FocusedMenuItem(
                                          title: const Text(
                                            "Delete",
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                          trailingIcon: const Icon(
                                            Icons.delete,
                                            color: Colors.redAccent,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              vehicleTexts[index].file = null;
                                              listImage.removeAt(index);
                                            });
                                          },
                                        ),
                                      ],
                                      onPressed: () {},
                                      child: Image.file(
                                        vehicleTexts[index].file!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container(
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
                                        Positioned(
                                          top: 6,
                                          right: 0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Text(
                                                vehicleTexts[index].sideText,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          );
                        } else {
                          return Container(
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    );
                  },
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
                            FormBuilderValidators.numeric(),
                            FormBuilderValidators.maxLength(11),
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
                          ],
                        ),
                        keyboardType: TextInputType.text,
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
                      FormBuilderTextField(
                        name: 'description',
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: '특이사항',
                          hintText: '예시 : 오토미션 / 사륜 / 썬루프 / 스마트키 등',
                          hintStyle:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: HexColor.fromHex('b3b3b3'),
                                    fontWeight: FontWeight.normal,
                                  ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onChanged: (String? newValue) {},
                        keyboardType: TextInputType.text,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  onPressed: listImage.length == 4
                      ? () {
                          _onSubmit(argument['plateNumber']);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    elevation: 6,
                    minimumSize: const Size(double.maxFinite, 60),
                    primary: HexColor.fromHex('5260ff'),
                  ),
                  child: const Text('견적의뢰'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
