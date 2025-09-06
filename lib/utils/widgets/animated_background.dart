import 'dart:math';

import 'package:corpofit_mobile/utils/widgets/animated_icon_widget.dart';
import 'package:flutter/material.dart';
import '../models/animated_icon.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;

  const AnimatedBackground({super.key, required this.child});

  @override
  State<StatefulWidget> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  List<ModelIcon> animatedIcons = [];
  final Random random = Random();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _generateAnimatedIcons();
  }

  void _generateAnimatedIcons() {
    final List<IconData> icons = [
      Icons.fitness_center_outlined,
      Icons.watch_rounded,
      Icons.bolt_outlined,
      Icons.favorite,
      Icons.sports_gymnastics,
      Icons.sports_baseball,
      Icons.sports_rugby,
      Icons.sports_kabaddi,
      Icons.sports_basketball,
      Icons.sports_soccer,
      Icons.sports_handball_rounded,
      Icons.battery_full_outlined,
      Icons.sports_football_rounded,
      Icons.sports_basketball_rounded,
      Icons.sports_basketball_sharp,
      Icons.sports_football,
      Icons.sports_football_outlined,
      Icons.sports_golf,
      Icons.sports_golf_rounded,
      Icons.sports_golf_sharp,
      Icons.sports_handball_outlined,
      Icons.sports_handball_rounded,
      Icons.sports_handball_sharp,
    ];

    for (int i = 0; i < 15; i++) {
      animatedIcons.add(
        ModelIcon(
          icon: icons[random.nextInt(icons.length)],
          startX: random.nextDouble(),
          startY: random.nextDouble(),
          endX: random.nextDouble(),
          endY: random.nextDouble(),
          size: 20.0 + random.nextDouble() * 30.0,
          color: Color.fromRGBO(
            random.nextInt(255),
            random.nextInt(255),
            random.nextInt(255),
            0.3 + random.nextDouble() * 0.4,
          ),
          duration: 5 + random.nextInt(10),
          delay: random.nextDouble() * 5,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.white70, Colors.white60],
        ),
      ),
      child: Stack(
        children: [
          ...animatedIcons.map(
            (animIcon) => AnimatedIconWidget(
              animatedIcon: animIcon,
              controller: _controller,
            ),
          ),

          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}
