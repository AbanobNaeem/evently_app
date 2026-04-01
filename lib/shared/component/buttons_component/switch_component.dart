import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';

class SwitchComponent extends StatelessWidget {
  final String? title; // optional
  final int initialIndex;
  final List<Widget> listOfIcons;
  final OnToggle onTapIndex;

  const SwitchComponent({
    super.key,
    this.title, // مش required
    required this.initialIndex,
    required this.listOfIcons,
    required this.onTapIndex,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    Widget toggle = Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primaryColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ToggleSwitch(
        minWidth: width * 0.16,
        initialLabelIndex: initialIndex,
        inactiveBgColor: AppColors.backGroundColorLight,
        totalSwitches: listOfIcons.length,
        customWidgets: List.generate(listOfIcons.length, (index) {
          bool isSelected = index == initialIndex;

          return IconTheme(
            data: IconThemeData(
              color: isSelected
                  ? Colors.white
                  : AppColors.primaryColor,
            ),
            child: listOfIcons[index],
          );
        }),
        activeBgColors: List.generate(
          listOfIcons.length,
              (_) => [AppColors.primaryColor],
        ),
        onToggle: onTapIndex,
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: title == null
          ? toggle
          : Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title!,
            style: AppStyles.bold20Primary,
          ),
          toggle,
        ],
      ),
    );
  }
}