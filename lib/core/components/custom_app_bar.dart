import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? color;
  final double? elevation;
  final List<Widget>? actions;
  final String? title;
  const CustomAppBar({
    super.key,
    this.color,
    this.title,
    this.elevation,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null ? Text(title!) : null,
      backgroundColor: color ?? Colors.blue,
      foregroundColor: Colors.white,
      elevation: elevation,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
