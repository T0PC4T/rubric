import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  final double pixelsPerLine;
  final Color canvasColor;
  final Color gridColor;
  final Offset offset;

  GridPainter({
    required this.canvasColor,
    required this.gridColor,
    required this.offset,
    this.pixelsPerLine = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (pixelsPerLine == 0) {
      return;
    }

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = canvasColor,
    );

    final paint = Paint()
      ..color = gridColor.withAlpha(50)
      ..strokeWidth = 2;

    for (double i = offset.dx;
        i <= size.width - offset.dx;
        i += pixelsPerLine) {
      canvas.drawLine(
          Offset(i, offset.dy), Offset(i, size.height - offset.dy), paint);
    }
    for (double i = offset.dy;
        i <= size.height - offset.dy;
        i += pixelsPerLine) {
      canvas.drawLine(
          Offset(offset.dx, i), Offset(size.width - offset.dx, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
