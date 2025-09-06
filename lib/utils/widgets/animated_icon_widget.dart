import 'dart:math';

import 'package:corpofit_mobile/utils/models/animated_icon.dart';
import 'package:flutter/material.dart';

class AnimatedIconWidget extends StatelessWidget {
  final ModelIcon animatedIcon;
  final AnimationController controller;
  const AnimatedIconWidget({
    super.key,
    required this.animatedIcon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final progress = (controller.value + animatedIcon.delay / 10) % 1.0;

        final currentX =
            animatedIcon.startX +
            (animatedIcon.endX - animatedIcon.startX) * progress;
        final currentY =
            animatedIcon.startY +
            (animatedIcon.endY - animatedIcon.startY) * progress;

        final rotation = progress * 2 * pi;

        final opacity = (sin(progress * 4 * pi) * 0.3 + 0.7).clamp(0.3, 1.0);

        return Positioned(
          left: currentX * MediaQuery.of(context).size.width,
          top: currentY * MediaQuery.of(context).size.height,
          child: Transform.rotate(
            angle: rotation,
            child: Opacity(
              opacity: opacity,
              child: Icon(
                animatedIcon.icon,
                size: animatedIcon.size,
                color: animatedIcon.color,
              ),
            ),
          ),
        );
      },
    );
  }
}
