import 'package:flutter/material.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';

class RubricButton extends StatefulWidget {
  // Styles
  final Color? backgroundColor;
  final Color? hoverColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
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
          color: hovered ? hoverColor : backgroundColor,
          width: widget.width,
          height: widget.height,
          child: widget.child,
        ),
      ),
    );
  }
}
