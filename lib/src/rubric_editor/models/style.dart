// ignore_for_file: public_member_api_docs, sort_constructors_first
// constant variables such as primary color, borderRadius

import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';

class RubricEditorStyle {
  final double radius;
  final double paddingUnit;
  final double fontSize;
  final double elevation;
  final Color theme;
  final Color dark;
  final Color light;
  final Color borderColor;

  const RubricEditorStyle({
    this.paddingUnit = 10,
    this.radius = 10,
    this.fontSize = 14,
    this.elevation = 6,
    this.theme = const Color.fromARGB(
      255,
      211,
      68,
      255,
    ), // color picker text should be black
    this.dark = const Color.fromARGB(255, 0, 0, 0),
    this.light = const Color.fromARGB(255, 255, 255, 255),
    this.borderColor = const Color.fromARGB(255, 212, 212, 212),
  });

  Color get primary4 => Color.lerp(theme, light, 0.4)!;

  Color get light1 => Color.lerp(dark, light, 0.1)!;
  Color get light2 => Color.lerp(dark, light, 0.2)!;
  Color get light4 => Color.lerp(dark, light, 0.4)!;
  Color get light6 => Color.lerp(dark, light, 0.6)!;
  Color get light8 => Color.lerp(dark, light, 0.8)!;

  EdgeInsets get padding => EdgeInsets.all(paddingUnit);
  BorderRadius get borderRadius => BorderRadius.circular(radius);

  static RubricEditorStyle of(BuildContext context) {
    final result = RubricEditorState.of(context).widget.style;
    return result;
  }
}
