import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../app_provider/home_screen_provider.dart';



class CategoriesTabs extends StatelessWidget {
  final List<TabItem> tabs;
  final int selectedIndex;
  final Function(int) onTabSelected;

  const CategoriesTabs({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
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
          return TabComponent(
            eventName: entry.value.title,
            tapIcon: entry.value.icon,
            isSelected: selectedIndex == entry.key,
          );
        }).toList(),
      ),
    );
  }
}

class TabComponent extends StatelessWidget {
  final String eventName ;
  final bool isSelected ;
  final IconData tapIcon ;
  const TabComponent({
    super.key,
    required this.eventName,
    required this.isSelected,
    required this.tapIcon
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
            ? AppColors.whiteColor
            :AppColors.transparentColor,
        borderRadius: BorderRadius.circular(46),
        border: Border.all(
          color: Colors.white,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            tapIcon,
            color: isSelected
                ? AppColors.primaryColor
                : Colors.white,
          ),
          const SizedBox(width: 8),
          Text(
            eventName,
            style: isSelected?
            AppStyles.bold16Primary: AppStyles.bold16white,
          ),
        ],
      ),
    );
  }
}