import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppStyles {
  static final AppStyles _singleton = AppStyles._internal();
  AppStyles._internal();
  static AppStyles get instance => _singleton;

  TextStyle headerTextStyles({
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return GoogleFonts.openSans(
      fontStyle: FontStyle.normal,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: AppColors.blackTextColor,
    );
  }

  TextStyle whiteTextStyles({
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return GoogleFonts.openSans(
      fontStyle: FontStyle.normal,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: AppColors.appBackgroundColor,
    );
  }

  TextStyle greenTextStyles({
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return GoogleFonts.openSans(
      fontStyle: FontStyle.normal,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: AppColors.greenTextColor,
    );
  }

  TextStyle redTextStyles({
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return GoogleFonts.openSans(
      fontStyle: FontStyle.normal,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: AppColors.redTextColor,
    );
  }
}
