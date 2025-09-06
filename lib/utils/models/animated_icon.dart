import 'package:flutter/material.dart';

class ModelIcon {
  final IconData icon;
  final double startX;
  final double startY;
  final double endX;
  final double endY;
  final double size;
  final Color color;
  final int duration;
  final double delay;

  ModelIcon({
    required this.icon,
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY,
    required this.size,
    required this.color,
    required this.duration,
    required this.delay,
  });
}
