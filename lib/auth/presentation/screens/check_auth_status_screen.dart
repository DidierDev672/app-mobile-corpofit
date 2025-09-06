import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class CheckAuthStatusScreen extends StatefulWidget {
  const CheckAuthStatusScreen({super.key});

  @override
  State<CheckAuthStatusScreen> createState() => _CheckAuthStatusScreenState();
}

class _CheckAuthStatusScreenState extends State<CheckAuthStatusScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _controller1 = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat();
    _controller2 = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    )..repeat();
    _controller3 = AnimationController(
      duration: Duration(seconds: 7),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([_controller1, _controller2, _controller3]),
        builder: (context, child) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  HSVColor.fromAHSV(
                    1.0,
                    _controller1.value * 360,
                    0.6,
                    1.0,
                  ).toColor(),
                  HSVColor.fromAHSV(
                    1.0,
                    _controller2.value * 360,
                    0.5,
                    0.8,
                  ).toColor(),
                  HSVColor.fromAHSV(
                    1.0,
                    _controller3.value * 360,
                    0.5,
                    0.7,
                  ).toColor(),
                ],
                begin: Alignment(
                  math.cos(_controller1.value * 2 * math.pi),
                  math.sin(_controller1.value * 2 * math.pi),
                ),
                end: Alignment(
                  math.cos(_controller2.value * 2 * math.pi),
                  math.sin(_controller2.value * 2 * math.pi),
                ),
              ),
            ),
            child: CustomPaint(
              painter: ComplexGradientPainter(
                _controller1.value,
                _controller2.value,
                _controller3.value,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.rotate(
                      angle: _controller1.value * 3 * math.pi,
                      child: Icon(
                        Icons.fire_extinguisher,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Corpofit App',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ComplexGradientPainter extends CustomPainter {
  final double value1, value2, value3;

  ComplexGradientPainter(this.value1, this.value2, this.value3);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < 3; i++) {
      final gradient = RadialGradient(
        colors: [
          HSVColor.fromAHSV(
            0.3,
            (value1 * 360 + i * 120) % 360,
            0.8,
            1.0,
          ).toColor(),
          HSVColor.fromAHSV(
            0.1,
            (value2 * 360 + i * 120) % 360,
            0.6,
            0.8,
          ).toColor(),
          Colors.transparent,
        ],
      );

      paint.shader = gradient.createShader(
        Rect.fromCircle(
          center: Offset(
            size.width * (0.5 + 0.3 * math.cos(value1 * 2 * math.pi + i * 2.0)),
            size.height *
                (0.5 + 0.3 * math.sin(value2 * 2 * math.pi + i * 1.5)),
          ),
          radius: 150 + 50 * math.sin(value3 * 2 * math.pi + i),
        ),
      );

      canvas.drawCircle(
        Offset(
          size.width * (0.5 + 0.3 * math.cos(value1 * 2 * math.pi + i * 2.0)),
          size.height * (0.5 + 0.3 * math.sin(value2 * 2 * math.pi + i * 1.5)),
        ),
        150 + 50 * math.sin(value3 * 2 * math.pi + i),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
