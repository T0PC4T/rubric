import 'dart:ui';

colorToJson(Color color) {
  return color.toARGB32();
}

Color colorFromJson(int value) {
  return Color(value);
}
