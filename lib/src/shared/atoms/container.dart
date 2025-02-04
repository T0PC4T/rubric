import 'package:flutter/material.dart';

class RubricContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  const RubricContainer({
    super.key,
    required this.child,
    required this.height,
    required this.width,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
      ),
      height: height,
      width: width,

      child: child,
    );
  }
}
