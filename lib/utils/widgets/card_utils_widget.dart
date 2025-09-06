import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardUtilsWidget extends StatelessWidget {
  final String title;
  final Color color;
  final Color textColor;
  final String route;
  const CardUtilsWidget({
    super.key,
    required this.title,
    required this.color,
    required this.textColor,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        context.go(route);
      },
      child: Container(
        width: double.infinity,
        height: 90,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomRight: Radius.circular(25),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          color: color,
        ),
        child: Center(
          child: Text(
            title,
            style: textStyle.titleLarge?.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
