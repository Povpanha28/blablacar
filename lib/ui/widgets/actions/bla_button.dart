import 'package:blablacar/ui/theme/theme.dart';
import 'package:flutter/material.dart';

enum BlaButtonType { primary, secondary }

class BlaButton extends StatelessWidget {
  final String title;
  final BlaButtonType type;
  final IconData? icon;
  final VoidCallback onPressed;
  const BlaButton({
    super.key,
    required this.title,
    required this.type,
    required this.onPressed,
    this.icon,
  });

  Color get bgColor => type == BlaButtonType.primary
      ? BlaColors.backGroundColor
      : BlaColors.white;

  Color get fgColor => type == BlaButtonType.primary
      ? BlaColors.white
      : BlaColors.backGroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: fgColor,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon),
          if (icon != null) SizedBox(width: 8),
          Text(title),
        ],
      ),
    );
  }
}
