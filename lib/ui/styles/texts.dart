/// Will contain all the textStyles that will be used in the theme or directly in the apps
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';
import 'fonts.dart';

TextStyle kHeadline1TextStyle = const TextStyle(
  fontFamily: AppFont.heading,
  fontWeight: FontWeight.w700,
  color: AppColors.headlineTextPrimary,
  fontSize: 28,
);

TextStyle kHeadline2TextStyle = const TextStyle(
  fontFamily: AppFont.heading,
  fontWeight: FontWeight.w700,
  color: AppColors.headlineTextPrimary,
  fontSize: 20,
);

TextStyle kHeadline3TextStyle = const TextStyle(
  fontFamily: AppFont.heading,
  fontWeight: FontWeight.bold,
  color: AppColors.headlineTextPrimary,
  fontSize: 18,
);

TextStyle kHeadline4TextStyle = const TextStyle(
  fontFamily: AppFont.heading,
  fontWeight: FontWeight.normal,
  color: AppColors.headlineTextPrimary,
  fontSize: 16,
);

TextStyle kHeadline5TextStyle = const TextStyle(
  // fontFamily: AppFont.body,
  fontWeight: FontWeight.w400,
  color: AppColors.headlineTextPrimary,
  fontSize: 14,
);

final TextStyle poppins = GoogleFonts.poppins(
  fontWeight: FontWeight.w400,
  color: AppColors.headlineTextPrimary,
  fontSize: 14,
);
final TextStyle headerPoppins = GoogleFonts.poppins(
  fontWeight: FontWeight.w400,
  color: AppColors.headlineTextPrimary,
  fontSize: 18,
);

TextStyle kSubtitle1TextStyle = const TextStyle(
  fontFamily: AppFont.body,
  fontWeight: FontWeight.bold,
  color: AppColors.textPrimary,
  fontSize: 18,
);

TextStyle kSubtitle2TextStyle = const TextStyle(
  fontFamily: AppFont.heading,
  fontWeight: FontWeight.bold,
  color: AppColors.textPrimary,
  fontSize: 14,
);

TextStyle kBodyText1TextStyle = const TextStyle(
  fontFamily: AppFont.body,
  fontWeight: FontWeight.w400,
  color: AppColors.textPrimary,
  fontSize: 14,
  height: 23 / 14, // Following the line height documentation.
);

TextStyle kBodyText2TextStyle = const TextStyle(
  fontFamily: AppFont.body,
  fontWeight: FontWeight.normal,
  color: AppColors.textPrimary,
  fontSize: 12,
);

/// This is the primary button Style
TextStyle kButtonTextStyle = const TextStyle(
  fontFamily: AppFont.body,
  fontWeight: FontWeight.bold,
  color: Colors.white,
  fontSize: 15,
);

const TextStyle kInputFieldTextStyle = TextStyle(
  fontFamily: AppFont.body,
  color: AppColors.inputText,
  fontWeight: FontWeight.w400,
  fontSize: 15,
  height: 19.38 / 15,
);

const TextStyle kHintTextStyle = TextStyle(
  fontFamily: AppFont.body,
  color: AppColors.hintText,
  fontWeight: FontWeight.w300,
  fontSize: 15,
  height: 19.38 / 15,
);

const TextStyle kInputLabelStyle = TextStyle(
  fontFamily: AppFont.heading,
  fontWeight: FontWeight.w300,
  color: AppColors.headlineTextPrimary,
  fontSize: 14,
);
