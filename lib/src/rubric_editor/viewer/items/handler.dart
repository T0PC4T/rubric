import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/models/elements.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';
import 'package:rubric/src/rubric_editor/viewer/items/element.dart';
import 'package:rubric/src/rubric_editor/viewer/items/position.dart';
import 'package:rubric/src/rubric_editor/viewer/items/scalar.dart';

class ElementHandlerWidget extends StatelessWidget {
  final ElementModel element;
  const ElementHandlerWidget({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    final style = RubricEditorStyle.of(context);
    final editorState = RubricEditorState.of(context);
    return RubricPositioned.fromElement(
      element: element,
      child: ElementHandlerRenderObjectWidget(
        element: element,
        child: Visibility(
          visible: editorState.edits.isSelected(element),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Positioned.fill(child: Container(color: Colors.amber)),
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
          ),
        ),
      ),
    );
  }
}
