import 'dart:math';

import 'package:flutter/material.dart';

class ArrowPainter extends CustomPainter {
  final Offset start;
  final Offset end;

  ArrowPainter(this.start, this.end);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.black
          ..strokeWidth = 8
          ..style = PaintingStyle.stroke;

    canvas.drawLine(start, end, paint);

    const arrowSize = 12.0;
    final angle = (end - start).direction;

    final path = Path();
    path.moveTo(end.dx, end.dy);
    path.lineTo(
      end.dx - arrowSize * cos(angle - pi / 6),
      end.dy - arrowSize * sin(angle - pi / 6),
    );
    path.moveTo(end.dx, end.dy);
    path.lineTo(
      end.dx - arrowSize * cos(angle + pi / 6),
      end.dy - arrowSize * sin(angle + pi / 6),
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ArrowPainter oldDelegate) => true;
}
