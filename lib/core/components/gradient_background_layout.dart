import 'package:flutter/material.dart';

class GradientBackgroundLayout extends StatelessWidget {
  final Widget child;

  const GradientBackgroundLayout({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue[50]!, Colors.blue[100]!],
        ),
      ),
      child: child,
    );
  }
}