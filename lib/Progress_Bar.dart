import 'dart:math';

import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double value;
  final Color backgroundColor;
  final Color progressColor;
  final TextStyle textStyle;
  final double strokeWidth;
  final double radius;
  final bool prLable;
  final bool point;

  const ProgressBar(this.value,
      {super.key,
      this.backgroundColor = Colors.grey,
      this.progressColor = Colors.lightBlue,
      this.textStyle = const TextStyle(color: Colors.lightBlue, fontSize: 20),
      this.strokeWidth = 5,
      required this.radius,
      this.prLable = false,
      this.point = false})
      : assert(radius <= 100 && radius >= 30);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            point
                ? Text(
                    "${value.toStringAsFixed(2)}",
                    style: textStyle,
                  )
                : Text(
                    "${value.floor()}",
                    style: textStyle,
                  ),
            prLable
                ? Text(
                    "%",
                    style: textStyle,
                  )
                : SizedBox(),
          ],
        ),
        CustomPaint(
            painter: OpenPainter(value, backgroundColor, progressColor,
                textStyle, strokeWidth, radius)),
      ],
    );
  }
}

class OpenPainter extends CustomPainter {
  final double value;
  final Color backgroundColor;
  final Color progressColor;
  final TextStyle textStyle;
  final double strokeWidth;
  final double radius;

  OpenPainter(this.value, this.backgroundColor, this.progressColor,
      this.textStyle, this.strokeWidth, this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    Paint background = Paint()
      ..color = backgroundColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    Paint top = Paint()
      ..color = progressColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    double arcAngle1 = 2 * pi * (100 / 100);
    canvas.drawArc(Rect.fromCircle(center: Offset(0, 0), radius: radius),
        -pi / 2, arcAngle1, false, background);

    double arcAngle2 = 2 * pi * (value / 100);
    canvas.drawArc(Rect.fromCircle(center: Offset(0, 0), radius: radius),
        -pi / 2, arcAngle2, false, top);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
