import 'package:flutter/material.dart';

class AppColors {
  static const int primaryColorValue = 0xFF2F4FFF;

  static Color error = Color(0xFFE52836);
  static Color warning = Color(0xFFF6A609);
  // static Color success = Color(0xFF2AC769);
  static const Color primary = Color(primaryColorValue);

  static const MaterialColor primarySwatch = MaterialColor(
    primaryColorValue,
    <int, Color>{
      50: Color(0xFFeaebff),
      100: Color(0xFFc9ccff),
      200: Color(0xFFa4abff),
      300: Color(0xFF7a89ff),
      400: Color(0xFF576cff),
      500: Color(primaryColorValue),
      600: Color(0xFF2a45f3),
      700: Color(0xFF1c39e6),
      800: Color(0xFF0a2bdb),
      900: Color(0xFF0006cb),
    },
  );

  static const int secondaryColorValue = 0xFFfe337a;

  static const MaterialColor secondarySwatch = MaterialColor(
    secondaryColorValue,
    <int, Color>{
      50: Color(0xFFffe4ec),
      100: Color(0xFFffbbd1),
      200: Color(0xFFff8eb2),
      300: Color(0xFFff5d93),
      400: Color(secondaryColorValue),
      500: Color(0xFFfd0062),
      600: Color(0xFFec005f),
      700: Color(0xFFd6005b),
      800: Color(0xFFc10059),
      900: Color(0xFF9b0053),
    },
  );

  static const Color scaffoldBgColor = Colors.white;
  // static const Color white = Color(0xFFE8E8E8);
  static const Color primaryBtnBg = Color(0xFF160A36);

  //Title texts, captions, inputs fields and everywhere else where black is required
  static const Color textPrimary = Color(0xFF160A36);

  // The most common headline textColor.
  static const Color headlineTextPrimary = Color(0xFF160A36);

  //text secondary
  static const Color textSecondary = Color(0xFF000000);

  // inputs fields
  static const Color inputText = Color(0xFF2F2F2F);

  static const Color inputBorder = Color(0xFFBBBBBB);

  @Deprecated("Use hintText instead")
  static const Color inputPlaceholder = Color(0xFFC4C4C4);

  static const Color hintText = Color(0xFF5E5E5E);

  static const Color normalText = Color(0xFF4E43A6);

  static const Color errorLight = Color(0xFFFCF3F6);
  static const Color errorLightAlt = Color(0xFFF9DEE0);

  static const Color iconColor = Color(0xFF040B45);

  static const Color lightGray = Color.fromRGBO(4, 11, 69, 1);

  static const Color green = Color(0xFF37CB95);

  static const Color red = Color(0xFFE52836);

  static const boxBorder = Color(0xFFF4F4F4);

  static const Color fieldColor = Color(0xFFF4F5FF);

  static const bottomSheetHandle = Color(0xFFE2E2E2);

  //ProductTesteTESTETES
  static const Color purpleNormal = Color(0xff8860E6);
  static const Color purpleDark = Color(0xff5B409B);

  //Base
  static const Color greyDark = Color(0xff202024);
  static const Color grayLight = Color(0xffF3F4FE);
  static const Color white = Color(0xffFFFFFF);

  //Feedback
  static const Color success = Color(0xff04D361);
  static const Color danger = Color(0xffFF8F8F);

  //Degrade
  static const Color degrade1 = Color(0xffDEE0FC);
  static const Color degrade2 = Color(0xffBC9FFF);
  static const Color degrade3 = Color(0xff996DFF);

  static Shader linearGradient = const LinearGradient(
    colors: <Color>[
      AppColors.degrade1,
      AppColors.degrade2,
      AppColors.degrade3,
    ],
  ).createShader(const Rect.fromLTWH(80, 0.0, 250.0, 0.0));
}
