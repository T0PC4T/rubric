import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  final double pixelsPerLine;
  final Color backgroundColor;

  GridPainter({required this.backgroundColor, required this.pixelsPerLine});
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = backgroundColor,
    );

    final paint = Paint()
      ..color = const Color.fromARGB(10, 0, 0, 0)
      ..strokeWidth = 2;

    for (double i = 0; i <= size.width; i += pixelsPerLine) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i <= size.height; i += pixelsPerLine) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
