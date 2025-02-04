import 'package:flutter/material.dart';
import 'package:rubric/src/elements/box/box_model.dart';
import 'package:rubric/src/elements/models/elements.dart';

class BoxEditorElement extends StatelessWidget {
  final ElementModel element;
  const BoxEditorElement({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    final boxElement = element.getProperties<BoxElementModel>();
    return ColoredBox(color: boxElement.color);
  }
}
