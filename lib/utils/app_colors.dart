import 'package:flutter/material.dart';

mixin AppColors {
  static const Color primary = Color(0xFF43C6AC);
  static const Color primaryBgColor = Color(0xff1B1B1B);
  static const Color accent = Color(0xFFFF6D11);
  static const Color buttonColor = Color(0xFF0AAD0A);
  static const Color buttonInActiveColor = Color(0xff545454);
  static const Color black = Colors.black;
  static const Color black02 = Color.fromRGBO(0, 0, 0, 0.2);
  static const Color black03 = Color.fromRGBO(0, 0, 0, 0.3);
  static const Color textColor = Color(0xffF0F0F0);
  static const Color lightTextColor = Color(0xFFDDDDDD);
  static const Color maleColor = Color.fromARGB(255, 77, 145, 168);
  static const Color femaleColor = Color.fromARGB(255, 188, 86, 169);
  static const Color bannerColor = Color(0xFFBC1313);
  static const Color cardColor = Color.fromARGB(255, 34, 33, 33);
  static const Color appBarShadowColor = Color.fromRGBO(31, 36, 45, 0.12);

  static const primaryGradient = LinearGradient(
    colors: [primary, Color.fromRGBO(79, 164, 91, 0.9)],
    begin: Alignment(0.5, 0),
    end: Alignment(0.49, 2.25),
    stops: [0, 1],
  );

  static const MaterialColor primaryTheme = MaterialColor(
    0xFF43C6AC,
    <int, Color>{
      50: primary,
      100: primary,
      200: primary,
      300: primary,
      400: primary,
      500: primary,
      600: primary,
      700: primary,
      800: primary,
      900: primary,
    },
  );
}
