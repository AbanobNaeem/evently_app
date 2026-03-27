import 'dart:ui';

import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static TextStyle bold20white = GoogleFonts.intelOneMono(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: AppColors.whiteColor,
  );
  static TextStyle bold16white = GoogleFonts.intelOneMono(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: AppColors.whiteColor,
  );
  static TextStyle bold20Black = GoogleFonts.intelOneMono(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: AppColors.blackColor,
  );
  static TextStyle bold16Black = GoogleFonts.intelOneMono(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: AppColors.blackColor,
  );
}
