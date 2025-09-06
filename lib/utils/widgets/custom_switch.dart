import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? activeColor;
  final Color? inactiveTrackColor;
  final Color? inactiveThumbColor;
  final Color? activeTrackColor;
  final String? activeText;
  final String? inactiveText;
  final TextStyle? textStyle;
  final double? switchWidth;
  final double? switchHeight;
  final MaterialTapTargetSize? materialTapTargetSize;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.inactiveTrackColor,
    this.inactiveThumbColor,
    this.activeTrackColor,
    this.activeText,
    this.inactiveText,
    this.textStyle,
    this.switchWidth,
    this.switchHeight,
    this.materialTapTargetSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: switchHeight,
      height: switchHeight,
      child: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: activeColor,
        inactiveThumbColor: inactiveThumbColor,
        inactiveTrackColor: inactiveTrackColor,
        activeTrackColor: activeTrackColor,
        materialTapTargetSize: materialTapTargetSize,
      ),
    );
  }
}
