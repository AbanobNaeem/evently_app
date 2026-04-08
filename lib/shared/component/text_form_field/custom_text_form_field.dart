import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final VoidCallback? onIconTap;
  final IconData? suffixIcon;
  final double height;
  final double width;
  final Color iconColor;
  final TextStyle? hintStyle;
  final TextStyle? searchStyle;
  final Color cursorColor;
  final TextInputAction? textInputAction;
  final Color outlineColor;
  final String? titleText;
  final int maxLines;
  final ValueChanged? onChange ;

  const CustomTextFormField({
    super.key,
    this.onChange,
    this.controller,
    required this.hintText,
    this.prefixIcon,
    this.textInputAction,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onIconTap,
    this.suffixIcon,
    this.height = 0,
    this.width = 0,
    this.iconColor = AppColors.greyColor,
    this.hintStyle,
    this.searchStyle,
    this.cursorColor = AppColors.greyColor,
    this.outlineColor = AppColors.greyColor,
    this.titleText,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(
        vertical: height,
        horizontal: width,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: titleText != null,
            child: Text(
              titleText ?? "",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          titleText != null ? SizedBox(height: size.height * 0.01) : SizedBox(),
          TextFormField(
            onChanged: onChange,
            maxLines: maxLines,
            textInputAction: textInputAction,
            style: searchStyle ?? AppStyles.bold16gray,
            cursorColor: cursorColor,
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: hintStyle ?? AppStyles.bold16gray,
              suffixIcon: suffixIcon != null
                  ? IconButton(
                      onPressed: onIconTap,
                      icon: Icon(
                        suffixIcon,
                        color: AppColors.greyColor,
                        size: 30,
                      ),
                    )
                  : null,
              prefixIcon: prefixIcon != null
                  ? Icon(prefixIcon, color: iconColor, size: 30)
                  : null,
              contentPadding: EdgeInsets.symmetric(
                vertical: size.height * 0.021,
                horizontal: size.width * 0.04,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: outlineColor, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: AppColors.redColor, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: AppColors.redColor, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
