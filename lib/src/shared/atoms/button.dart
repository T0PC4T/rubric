import 'package:flutter/material.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';

class RubricButton extends StatefulWidget {
  // Styles
  final Color? backgroundColor;
  final Color? hoverColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? radius;
  // Core
  final VoidCallback onTap;
  final Widget child;
  const RubricButton({
    super.key,
    this.backgroundColor,
    this.hoverColor,
    required this.child,
    this.width,
    this.height,
    this.radius,
    required this.onTap,
    this.padding,
  });

  @override
  State<RubricButton> createState() => RubricButtonState();
}

class RubricButtonState extends State<RubricButton> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final styles = RubricEditorStyle.of(context);
    final backgroundColor = widget.backgroundColor ?? styles.light;
    final hoverColor = widget.hoverColor ?? styles.theme;

    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            hovered = true;
          });
        },

        onExit: (event) {
          setState(() {
            hovered = false;
          });
        },

        child: Container(
          alignment: Alignment.center,
          padding: widget.padding,
          width: widget.width,
          height: widget.height,

          decoration: BoxDecoration(
            color: hovered ? hoverColor : backgroundColor,
            borderRadius: BorderRadius.circular(widget.radius ?? 0),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
