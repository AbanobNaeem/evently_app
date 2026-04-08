import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import 'EventTapComponent.dart';

class CategoriesTabs extends StatelessWidget {
  final List tabs;
  final int selectedIndex;
  final Function(int) onTabSelected;
  final bool isPrimaryBackground;
  final Color outlineColor;
  final Color selectedColor;
  final TextStyle? selectedTextStyle;
  final TextStyle? unSelectedTextStyle;
  final Color selectedIconColor;
  final Color unSelectedIconColor;

  const CategoriesTabs({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    this.isPrimaryBackground = false,
    this.outlineColor = AppColors.whiteColor,
    this.selectedColor = AppColors.whiteColor,
    this.selectedTextStyle,
    this.unSelectedTextStyle,
    this.selectedIconColor = AppColors.primaryColor,
    this.unSelectedIconColor = AppColors.whiteColor,
  });

  @override
  Widget build(BuildContext context) {
    final currentSelectedColor =
    isPrimaryBackground ? AppColors.primaryColor : selectedColor;

    final currentOutlineColor =
    isPrimaryBackground ? AppColors.primaryColor : outlineColor;

    final currentSelectedIconColor =
    isPrimaryBackground ? AppColors.whiteColor : selectedIconColor;

    final currentUnSelectedIconColor =
    isPrimaryBackground ? AppColors.primaryColor : unSelectedIconColor;

    final currentSelectedTextStyle =
    isPrimaryBackground ? AppStyles.bold16white : selectedTextStyle;

    final currentUnSelectedTextStyle =
    isPrimaryBackground ? AppStyles.bold16Primary : unSelectedTextStyle;

    return DefaultTabController(
      length: tabs.length,
      child: TabBar(
        padding: EdgeInsets.zero,
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        indicatorColor: Colors.transparent,
        dividerColor: Colors.transparent,
        labelPadding: EdgeInsets.zero,
        onTap: onTabSelected,
        tabs: tabs.asMap().entries.map((entry) {
          return EventTapComponent(
            selectedIconColor: currentSelectedIconColor,
            unSelectedIconColor: currentUnSelectedIconColor,
            outlineColor: currentOutlineColor,
            selectedColor: currentSelectedColor,
            selectedTextStyle: currentSelectedTextStyle,
            unSelectedTextStyle: currentUnSelectedTextStyle,
            eventName: entry.value.title,
            tapIcon: entry.value.icon,
            isSelected: selectedIndex == entry.key,
          );
        }).toList(),
      ),
    );
  }
}