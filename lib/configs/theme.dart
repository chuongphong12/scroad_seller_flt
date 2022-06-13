import 'package:flutter/material.dart';
import 'package:scroad_seller_flutter/extensions/hexadecimal_convert.dart';

ThemeData theme() {
  return ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: HexColor.fromHex('#ffc000'),
    primaryColorDark: HexColor.fromHex('#fdff73'),
    primaryColorLight: HexColor.fromHex('#ffc519'),
    scaffoldBackgroundColor: HexColor.fromHex('ffffff'),
    fontFamily: 'NotoSansKR',
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Color(0xFF1B070B),
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        color: Color(0xFF1B070B),
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headline3: TextStyle(
        color: Color(0xFF1B070B),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      headline4: TextStyle(
        color: Color(0xFF1B070B),
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      headline5: TextStyle(
        color: Color(0xFF1B070B),
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      headline6: TextStyle(
        color: Color(0xFF1B070B),
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodyText1: TextStyle(
        color: Color(0xFF1B070B),
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      bodyText2: TextStyle(
        color: Color(0xFF1B070B),
        fontSize: 10,
        fontWeight: FontWeight.normal,
      ),
    ),
    appBarTheme: AppBarTheme(
      color: HexColor.fromHex('#ffc000'),
    ),
    colorScheme: ColorScheme(
      primary: HexColor.fromHex('#b5b5b5'),
      secondary: const Color(0xFFe84545),
      background: const Color(0xFFFFFFFF),
      surface: const Color(0xFFFFFFFF),
      error: const Color(0x00000000),
      brightness: Brightness.light,
      onPrimary: const Color(0xFFFFFFFF),
      onSecondary: const Color(0xFFFFFFFF),
      onError: const Color(0xFF2b2e4a),
      onBackground: const Color(0xFF2b2e4a),
      onSurface: const Color(0xFF2b2e4a),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
    ),
  );
}
