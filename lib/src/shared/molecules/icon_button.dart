import 'package:flutter/material.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';
import 'package:rubric/src/shared/shared.dart';

class RubricIconButton extends StatelessWidget {
  final double size;
  final VoidCallback onTap;
  final IconData iconData;
  final bool background;
  final bool isSelected;
  const RubricIconButton({
    super.key,
    required this.size,
    required this.onTap,
    required this.iconData,
    this.background = true,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = RubricEditorStyle.of(context);
    return RubricButton(
      width: size,
      height: size,
      backgroundColor: background ? style.light : style.light2,
      hoverColor: style.light6,
      onTap: onTap,
      child: Icon(
        iconData,
        color: background ? style.dark : style.light,
        size: size * 0.5,
      ),
    );
  }
}
