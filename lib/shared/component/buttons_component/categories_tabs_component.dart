import 'package:evently_app/shared/component/buttons_component/EventTapComponent.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

class CategoriesTabs extends StatelessWidget {
  final List tabs;
  final int selectedIndex;
  final Function(int) onTabSelected;
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
    this.outlineColor = AppColors.whiteColor,
    this.selectedColor = AppColors.whiteColor,
    this.selectedTextStyle,
    this.unSelectedTextStyle,
    this.selectedIconColor  = AppColors.primaryColor,
    this.unSelectedIconColor = AppColors.whiteColor,
  });

  @override
  Widget build(BuildContext context) {
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
            selectedIconColor: selectedIconColor,
            unSelectedIconColor: unSelectedIconColor,
            outlineColor: outlineColor ,
            selectedColor: selectedColor,
            selectedTextStyle: selectedTextStyle,
            unSelectedTextStyle: unSelectedTextStyle,
            eventName: entry.value.title,
            tapIcon: entry.value.icon,
            isSelected: selectedIndex == entry.key,
          );
        }).toList(),
      ),
    );
  }
}

