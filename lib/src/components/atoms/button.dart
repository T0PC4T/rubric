import 'package:flutter/material.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';

class RubricButton extends StatefulWidget {
  // Styles
  final Color? backgroundColor;
  final Color? hoverColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? radius;
  final Color? borderColor;
  final double? borderWidth;
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
    this.margin,
    this.borderColor,
    this.borderWidth,
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
          margin: widget.margin,
          alignment: Alignment.center,
          padding: widget.padding,
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: hovered ? hoverColor : backgroundColor,
            borderRadius: BorderRadius.circular(widget.radius ?? 0),
            border:
                widget.borderWidth == null
                    ? null
                    : Border.all(
                      color: widget.borderColor ?? styles.borderColor,
                      width: widget.borderWidth!,
                    ),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
