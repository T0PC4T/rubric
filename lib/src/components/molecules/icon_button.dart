import 'package:flutter/material.dart';
import 'package:rubric/src/components/shared.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';
import 'package:rubric/src/rubric_editor/toolbar/element_toolbar.dart';

class RubricIconButton extends StatelessWidget {
  final double size;
  final VoidCallback onTap;
  final IconData iconData;
  final bool isSelected;
  final bool isDark;
  const RubricIconButton({
    super.key,
    required this.size,
    required this.onTap,
    required this.iconData,
    this.isSelected = false,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = RubricEditorStyle.of(context);
    return RubricButton(
      width: size,
      height: size,
      backgroundColor: isDark ? style.dark : style.light,
      hoverColor: style.theme,
      onTap: onTap,
      child: Icon(
        iconData,
        color: isDark ? style.light : style.dark,
        size: ElementToolbarWidget.iconSize,
      ),
    );
  }
}

class RubricIconTextButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData iconData;
  final String text;
  final bool isSelected;
  final bool isDark;
  const RubricIconTextButton({
    super.key,
    required this.onTap,
    required this.iconData,
    required this.text,
    this.isSelected = false,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = RubricEditorStyle.of(context);
    return RubricButton(
      backgroundColor: isDark ? style.dark : style.light,
      hoverColor: style.theme,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: style.paddingUnit * 0.5),
        child: Row(
          spacing: style.paddingUnit * 0.5,

          children: [
            Icon(
              iconData,
              color: isDark ? style.light : style.dark,
              size: ElementToolbarWidget.iconSize,
            ),
            RubricText(text),
          ],
        ),
      ),
    );
  }
}
