import 'package:flutter/cupertino.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';

class EventTapComponent extends StatelessWidget {
  final String eventName ;
  final bool isSelected ;
  final IconData tapIcon ;
  final Color selectedColor;
  final Color outlineColor;
  final TextStyle? selectedTextStyle ;
  final TextStyle? unSelectedTextStyle ;
  final Color selectedIconColor ;
  final Color unSelectedIconColor ;


  const EventTapComponent({
    super.key,
    required this.eventName,
    required this.isSelected,
    required this.tapIcon,
    this.selectedColor = AppColors.whiteColor,
    this.outlineColor = AppColors.whiteColor,
    this.selectedTextStyle ,
    this.unSelectedTextStyle ,
    this.selectedIconColor = AppColors.primaryColor,
    this.unSelectedIconColor = AppColors.whiteColor,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.01,
      ),
      margin:  EdgeInsetsGeometry.symmetric(
          horizontal: size.width * 0.02,
          vertical: size.height * 0.01
      ) ,
      decoration: BoxDecoration(
        color: isSelected
            ? selectedColor
            :AppColors.transparentColor,
        borderRadius: BorderRadius.circular(46),
        border: Border.all(
          color: outlineColor,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            tapIcon,
            color: isSelected
                ? selectedIconColor
                : unSelectedIconColor,
          ),
          const SizedBox(width: 8),
          Text(
            eventName,
            style: isSelected?
            selectedTextStyle ?? AppStyles.bold16Primary :
            unSelectedTextStyle ?? AppStyles.bold16white,
          ),
        ],
      ),
    );
  }
}