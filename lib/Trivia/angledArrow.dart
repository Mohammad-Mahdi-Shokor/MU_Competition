import 'dart:math';

import 'package:flutter/material.dart';

class AngledArrowPainter extends CustomPainter {
  final Offset start;
  final Offset end;

  AngledArrowPainter(this.start, this.end);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke;

    // Middle point for the "bend"
    Offset bend = Offset(start.dx, end.dy);

    // Draw the polyline
    final path =
        Path()
          ..moveTo(start.dx, start.dy)
          ..lineTo(bend.dx, bend.dy) // first vertical/horizontal segment
          ..lineTo(end.dx, end.dy); // final segment to the target

    canvas.drawPath(path, paint);

    // Draw arrow head
    _drawArrowHead(canvas, paint, end, bend);
  }

  void _drawArrowHead(Canvas canvas, Paint paint, Offset tip, Offset from) {
    const double size = 10;

    final angle = (from - tip).direction;
    final path = Path();
    path.moveTo(tip.dx, tip.dy);
    path.lineTo(
      tip.dx + size * cos(angle + 0.4),
      tip.dy + size * sin(angle + 0.4),
    );
    path.moveTo(tip.dx, tip.dy);
    path.lineTo(
      tip.dx + size * cos(angle - 0.4),
      tip.dy + size * sin(angle - 0.4),
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
