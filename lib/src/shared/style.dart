// ignore_for_file: public_member_api_docs, sort_constructors_first
// constant variables such as primary color, borderRadius

import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';

class RubricEditorStyle {
  final double borderRadius;
  final double paddingUnit;
  final double fontSize;
  final Color primaryColor;
  final Color foregroundColor;
  final Color backgroundColor;
  final Color borderColor;
  const RubricEditorStyle({
    this.paddingUnit = 12,
    this.borderRadius = 12,
    this.fontSize = 14,
    this.primaryColor = const Color.fromARGB(255, 71, 151, 255),
    this.foregroundColor = const Color.fromARGB(255, 0, 0, 0),
    this.backgroundColor = const Color.fromARGB(255, 255, 255, 255),
    this.borderColor = const Color.fromARGB(255, 212, 212, 212),
  });

  static RubricEditorStyle? of(BuildContext context) {
    return RubricEditorState.of(context).widget.style;
  }
}
