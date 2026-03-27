import 'package:flutter/material.dart';

import '../utils/app_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "App Home Screen",
          style: AppStyles.bold20Black,
        ),
      ),
    );
  }
}
