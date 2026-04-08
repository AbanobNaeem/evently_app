import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class TextButtonComponent extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color underlineColor;
  final Alignment alignment;
  final bool showUnderline; // ← هنا الإضافة

  const TextButtonComponent({
    super.key,
    required this.text,
    required this.onPressed,
    this.underlineColor = Colors.blue,
    this.alignment = Alignment.centerRight,
    this.showUnderline = true, // default: show underline
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: AppStyles.bold16Primary.copyWith(
            decoration: showUnderline ? TextDecoration.underline : TextDecoration.none,
            decorationColor: AppColors.primaryColor
          ),
        ),
      ),
    );
  }
}