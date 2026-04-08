import 'package:flutter/material.dart';
class SquareButton extends StatelessWidget {
  final Widget child;
  final Color color;
  const SquareButton({super.key, required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: child,
      ),
    );
  }
}
