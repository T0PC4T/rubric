import 'package:flutter/material.dart';
import 'package:rubric/src/models/elements.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';
import 'package:rubric/src/rubric_editor/viewer/items/scalar.dart';

class ElementHandlerWidget extends StatelessWidget {
  final ElementModel element;
  const ElementHandlerWidget({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    final style = RubricEditorStyle.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        // Positioned.fill(child: Container(color: Colors.amber)),
        Positioned.fill(
          child: AbsorbPointer(
            child: element.type.editorBuilder(element: element),
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: style.dark),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: ScalarWidget(element: element, scalarIndex: 0),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: ScalarWidget(element: element, scalarIndex: 1),
        ),
      ],
    );
  }
}
