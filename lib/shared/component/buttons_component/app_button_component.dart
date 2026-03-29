import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';

class AppButtonComponent extends StatelessWidget {
  final VoidCallback onButtonTap;
  final Color buttonColor;
  final String buttonName;
  final IconData? icon;
  final bool centerText;
  final double buttonHeightPadding;
  final double buttonWidthPadding;



  const AppButtonComponent({
    super.key,
    required this.onButtonTap,
    required this.buttonColor,
    required this.buttonName,
    this.icon,
    this.centerText = false,
    this.buttonHeightPadding = 0.04,
    this.buttonWidthPadding = 0.04,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * buttonHeightPadding,
        horizontal: width * buttonWidthPadding,
      ),
      child: ElevatedButton(
        onPressed: onButtonTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.02,
          ),
        ),
        child: Row(
          mainAxisAlignment: centerText ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: AppColors.whiteColor,
                size: 24,
              ),
              SizedBox(width: width * 0.02),
            ],
            Text(
              buttonName,
              style: AppStyles.bold20white,
            ),
          ],
        ),
      ),
    );
  }
}