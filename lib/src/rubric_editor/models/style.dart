// ignore_for_file: public_member_api_docs, sort_constructors_first
// constant variables such as primary color, borderRadius

import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';

class RubricEditorStyle {
  static const paddingUnit = 10.0;
  static const minimumFontSize = 24;

  final String logoUrl;
  final double radius;
  final double fontSize;
  final FontWeight fontWeight;
  final double elevation;
  final Color theme;
  final Color dark;
  final Color light;
  final Color borderColor;
  final List<Color> brandColors;

  const RubricEditorStyle({
    required this.logoUrl,
    this.radius = 8,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.elevation = 6,
    this.brandColors = const [
      Color.fromARGB(255, 0, 162, 255),
      Color.fromARGB(255, 255, 178, 10),
      Color.fromARGB(255, 255, 23, 119),
    ],
    this.theme = const Color.fromARGB(
      255,
      0,
      162,
      255,
    ), // color picker text should be black
    this.dark = const Color.fromARGB(255, 0, 0, 0),
    this.light = const Color.fromARGB(255, 255, 255, 255),
    this.borderColor = const Color.fromARGB(255, 212, 212, 212),
  });

  Color get theme4 => Color.lerp(theme, light, 0.4)!; // for theme hover

  Color get light1 => Color.lerp(dark, light, 0.1)!;
  Color get light2 => Color.lerp(dark, light, 0.2)!;
  Color get light4 => Color.lerp(dark, light, 0.4)!;
  Color get light7 => Color.lerp(dark, light, 0.7)!; // borders
  Color get light9 => Color.lerp(dark, light, 0.9)!; // light hoverover
  Color get light95 => Color.lerp(dark, light, 0.95)!;

  double get paddingD => paddingUnit;
  EdgeInsets get padding => EdgeInsets.all(paddingUnit);
  BorderRadius get borderRadius => BorderRadius.circular(radius);

  static RubricEditorStyle of(BuildContext context) {
    final result = RubricEditorState.of(context).widget.style;
    return result;
  }
}
