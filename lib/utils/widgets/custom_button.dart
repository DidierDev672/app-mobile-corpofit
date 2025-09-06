import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? label;
  final Color? buttonColor;
  final Color? textColor;
  final void Function()? onPressed;

  const CustomButton({
    super.key,
    this.label,
    this.buttonColor,
    this.textColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(10);
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: buttonColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: radius,
            bottomRight: radius,
            topLeft: radius,
          ),
        ),
      ),

      onPressed: onPressed,
      child: Text(
        label!,
        style: textStyle.titleMedium?.copyWith(
          fontSize: size.width * 0.05,
          color: textColor,
        ),
      ),
    );
  }
}
