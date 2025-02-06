import 'package:flutter/material.dart';

class RubricContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  const RubricContainer({
    super.key,
    required this.child,
    required this.height,
    required this.width,
    this.color,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black, width: 1),
      ),
      height: height,
      width: width,

      child: child,
    );
  }
}
