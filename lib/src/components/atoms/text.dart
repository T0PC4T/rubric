import 'package:flutter/material.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';

enum TextType {
  title(1.3),
  paragraph(1),
  small(0.8);

  final double sizeMultiplier;
  const TextType(this.sizeMultiplier);
}

class RubricText extends StatelessWidget {
  final String text;
  final TextType textType;
  const RubricText(this.text, {super.key, this.textType = TextType.paragraph});

  @override
  Widget build(BuildContext context) {
    final styles = RubricEditorStyle.of(context);
    return Text(
      text,
      style: TextStyle(
        color: styles.dark,
        fontSize: styles.fontSize * textType.sizeMultiplier,
      ),
    );
  }
}
