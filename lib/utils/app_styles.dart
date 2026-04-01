import 'dart:ui';

import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static TextStyle bold20white = GoogleFonts.inter(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: AppColors.whiteColor,
  );
  static TextStyle bold16gray = GoogleFonts.inter(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: AppColors.greyColor,
  );
  static TextStyle bold24white = GoogleFonts.inter(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: AppColors.whiteColor,
  );
  static TextStyle regular20white = GoogleFonts.inter(
    fontWeight: FontWeight.w500,
    fontSize: 20,
    color: AppColors.whiteColor,
  );
  static TextStyle bold16white = GoogleFonts.inter(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: AppColors.whiteColor,
  );
  static TextStyle bold20Black = GoogleFonts.inter(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: AppColors.blackColor,
  );
  static TextStyle bold16Black = GoogleFonts.inter(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: AppColors.blackColor,
  );

  static TextStyle bold20Primary = GoogleFonts.inter(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: AppColors.primaryColor,
  );

  static TextStyle bold24Primary = GoogleFonts.inter(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: AppColors.primaryColor,
  );

  static TextStyle bold16Primary = GoogleFonts.inter(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: AppColors.primaryColor,
  );

}
