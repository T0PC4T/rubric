import 'package:flutter/material.dart';
import 'package:rubric/src/elements/box/model_box.dart';
import 'package:rubric/src/models/elements.dart';

class RuBoxEditorElement extends StatelessWidget {
  final ElementModel element;
  const RuBoxEditorElement({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    final boxElement = element.getProperties<BoxElementModel>();
    return ColoredBox(color: boxElement.color);
  }
}
