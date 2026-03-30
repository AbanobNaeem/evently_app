import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class CircleButtonComponent extends StatelessWidget {
  final VoidCallback onButtonTap;
  final bool isBack  ;

  const CircleButtonComponent({
    super.key,
    required this.onButtonTap,
    this.isBack= false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onButtonTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.primaryColor,
            width: 2,
          ),
        ),
        child: Center(
          child: Icon(isBack ? Icons.arrow_back : Icons.arrow_forward, color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
