import 'package:flutter/material.dart';
import 'package:rubric/src/rubric_editor/style.dart';

class RubricText extends StatelessWidget {
  final String text;
  const RubricText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final styles = RubricEditorStyle.of(context);
    return Text(
      text,
      style: TextStyle(
        color: styles.foregroundColor,
        fontSize: styles.fontSize,
      ),
    );
  }
}
