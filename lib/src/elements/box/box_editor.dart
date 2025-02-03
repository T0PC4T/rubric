import 'package:flutter/material.dart';
import 'package:rubric/src/elements/box/box_model.dart';
import 'package:rubric/src/elements/models/elements.dart';

class RuBoxEditorElement extends StatelessWidget {
  final ElementModel element;
  const RuBoxEditorElement({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    final boxElement = element.getProperties<BoxElementModel>();
    return ColoredBox(color: boxElement.color);
  }
}
