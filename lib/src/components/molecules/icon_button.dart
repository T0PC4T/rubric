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
  final bool disabled;
  const RubricIconButton({
    super.key,
    required this.size,
    required this.onTap,
    required this.iconData,
    this.isSelected = false,
    this.disabled = false,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = RubricEditorStyle.of(context);
    final backgroundColor = isDark ? style.dark : style.light;

    return RubricButton(
      width: size,
      height: size,
      backgroundColor: backgroundColor,
      hoverColor:
          disabled
              ? backgroundColor
              : isDark
              ? style.theme
              : style.light9,
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
      hoverColor: style.light9,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: RubricEditorStyle.paddingUnit * 0.5,
        ),
        child: Row(
          spacing: RubricEditorStyle.paddingUnit * 0.5,

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

class RubricColorButton extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;
  const RubricColorButton({
    super.key,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(RubricEditorStyle.paddingUnit),
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),

        width: ElementToolbarWidget.iconSize,
        height: ElementToolbarWidget.iconSize,
      ),
    );
  }
}
