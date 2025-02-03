import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  final double pixelsPerLine;

  GridPainter(this.pixelsPerLine);
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.grey.shade300
          ..strokeWidth = 1;

    for (double i = 0; i < size.width; i += pixelsPerLine) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += pixelsPerLine) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
