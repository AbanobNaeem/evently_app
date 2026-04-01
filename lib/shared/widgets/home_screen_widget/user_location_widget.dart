import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';

class UserLocationWidget extends StatelessWidget {
  final String userLocation;
  const UserLocationWidget({super.key, required this.userLocation});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding:  EdgeInsets.only(top: size.height * 0.01),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            color: AppColors.whiteColor,
            size: 30,
          ),
          Text(userLocation, style: AppStyles.bold16white),
        ],
      ),
    );
  }
}
