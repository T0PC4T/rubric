import 'package:flutter/material.dart';
import 'package:rubric/src/elements/box/box_model.dart';
import 'package:rubric/src/elements/elements.dart';
import 'package:rubric/src/models/elements.dart';
import 'package:rubric/src/rubric_editor/editor.dart';

class BoxEditorElement extends StatelessWidget
    implements InteractiveElementWidget {
  final ElementModel element;
  const BoxEditorElement({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    final boxElement = element.getProperties<BoxElementModel>();
    return ColoredBox(color: boxElement.color);
  }

  @override
  onFocus(RubricEditorState editorState) {
    editorState.showToolbar(element);
  }

  @override
  onSelect(RubricEditorState editorState) {
    editorState.showToolbar(element);
  }
}
