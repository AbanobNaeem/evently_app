import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';

class AppButtonComponent extends StatelessWidget {
  final VoidCallback onButtonTap;
  final Color buttonColor;
  final String buttonName;
  final Widget? leading;
  final bool centerText;
  final bool isOutlined;
  final double buttonHeightPadding;
  final double buttonWidthPadding;
  final bool arrowIcon;

  const AppButtonComponent({
    super.key,
    required this.onButtonTap,
    required this.buttonColor,
    required this.buttonName,
    this.leading,
    this.centerText = false,
    this.isOutlined = false,
    this.buttonHeightPadding = 0.04,
    this.buttonWidthPadding = 0.04,
    this.arrowIcon = false
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
          minimumSize: Size(double.infinity, height * 0.07),
          backgroundColor:
          isOutlined ? Colors.transparent : buttonColor,
          shadowColor: Colors.transparent,
          elevation: isOutlined ? 0 : 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: isOutlined
                ? BorderSide(
              color: buttonColor,
              width: 2,
            )
                : BorderSide.none,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.02,
          ),
        ),
        child: Row(
          mainAxisAlignment: centerText
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            if (leading != null) ...[
              leading!,
              SizedBox(width: width * 0.02),
            ],
            Text(
              buttonName,
              style: isOutlined
                  ? AppStyles.bold20Primary
                  : AppStyles.bold20white,
            ),
            if (arrowIcon) ...[
              Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 25,
                color: AppColors.primaryColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}