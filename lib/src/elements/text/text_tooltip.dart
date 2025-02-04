import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/elements/models/elements.dart';

class TextTooltipWidget extends StatelessWidget {
  final ElementModel element;
  final FleatherController controller;
  const TextTooltipWidget({
    super.key,
    required this.element,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final editorState = RubricEditorState.of(context);
    return FleatherToolbar(
      children: [
        ToggleStyleButton(
          attribute: ParchmentAttribute.bold,
          childBuilder: (context, attribute, icon, isToggled, onPressed) {
            return IconButton(icon: Icon(icon, size: 20), onPressed: onPressed);
          },
          icon: Icons.format_bold,
          controller: controller,
        ),
        ToggleStyleButton(
          attribute: ParchmentAttribute.italic,
          childBuilder: (context, attribute, icon, isToggled, onPressed) {
            return IconButton(icon: Icon(icon, size: 20), onPressed: onPressed);
          },
          icon: Icons.format_italic,
          controller: controller,
        ),
        ToggleStyleButton(
          attribute: ParchmentAttribute.underline,
          childBuilder: (context, attribute, icon, isToggled, onPressed) {
            return IconButton(icon: Icon(icon, size: 20), onPressed: onPressed);
          },
          icon: Icons.format_underline,
          controller: controller,
        ),
      ],
    );
  }
}
