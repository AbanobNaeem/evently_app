import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  final String text;
  final double thickness;
  final double spacing;

  const OrDivider({
    super.key,
    this.text = "Or",
    this.thickness = 2,
    this.spacing = 20,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.01 ),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: AppColors.primaryColor,
              thickness: thickness,
            ),
          ),
          SizedBox(width: spacing),
          Text(
            text,
            style: AppStyles.bold20Primary,
          ),
          SizedBox(width: spacing),
          Expanded(
            child: Divider(
              color: AppColors.primaryColor,
              thickness: thickness,
            ),
          ),
        ],
      ),
    );
  }
}