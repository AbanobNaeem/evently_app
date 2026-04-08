import 'package:evently_app/shared/component/buttons_component/text_button_component.dart';
import 'package:flutter/material.dart';

class DateAndTimeButton extends StatelessWidget {

  final IconData icon ;
  final String buttonName ;
  final String title ;
  final VoidCallback buttonTap ;
  const DateAndTimeButton({
    super.key,
    required this.icon,
    required this.buttonName,
    required this.title,
    required this.buttonTap
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      children: [
        Icon(
            icon,
            size: 35,
            color: Theme.of(context).hintColor
        ),
        SizedBox(width: size.width * 0.01),
        Text(
            title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Spacer(),
        TextButtonComponent(
            showUnderline: false,
            text: buttonName,
            onPressed: buttonTap)
      ],
    );
  }
}
