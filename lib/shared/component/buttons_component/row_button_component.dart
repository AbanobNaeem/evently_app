import 'package:flutter/material.dart';
import '../../../utils/app_styles.dart';
import 'text_button_component.dart';

class AuthRedirectRow extends StatelessWidget {
  final String titleText;
  final String actionText;
  final VoidCallback onPressed;

  const AuthRedirectRow({
    super.key,
    required this.titleText,
    required this.actionText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          titleText,
          style: AppStyles.bold16gray,
        ),
        TextButtonComponent(
          text: actionText,
          onPressed: onPressed,
        ),
      ],
    );
  }
}