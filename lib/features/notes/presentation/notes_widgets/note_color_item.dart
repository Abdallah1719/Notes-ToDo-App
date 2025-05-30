import 'package:flutter/material.dart';

class ColorItem extends StatelessWidget {
  const ColorItem({super.key, required this.isActive, required this.color});
  final bool isActive;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return isActive
        ? CircleAvatar(
            backgroundColor: Colors.white,
            radius: 26,
            child: CircleAvatar(
              backgroundColor: color,
              radius: 22,
            ),
          )
        : CircleAvatar(
            backgroundColor: color,
            radius: 22,
          );
  }
}
