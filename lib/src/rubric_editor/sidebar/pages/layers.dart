import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/models/elements.dart';
import 'package:rubric/src/shared/atoms/container.dart';
import 'package:rubric/src/shared/atoms/text.dart';

class LayersPageWidget extends StatelessWidget {
  const LayersPageWidget({super.key});

  int reverseIndex(int originalIndex, int listLength) {
    return (listLength - 1) - originalIndex;
  }

  @override
  Widget build(BuildContext context) {
    final editorState = RubricEditorState.of(context);
    return ValueListenableBuilder(
      valueListenable: editorState.canvas,
      builder: (context, canvas, child) {
        return Padding(
          padding: EdgeInsets.all(editorState.style.paddingUnit),
          child: ReorderableListView(
            header: RubricText("Layers", textType: TextType.title),
            onReorder: (oldIndex, newIndex) {
              int listLength = canvas.elements.length;
              int reversedOldIndex = reverseIndex(oldIndex, listLength);
              int reversedNewIndex = reverseIndex(newIndex, listLength);
              editorState.canvas.reorderElements(
                reversedOldIndex,
                reversedNewIndex,
              );
            },
            padding: EdgeInsets.symmetric(
              vertical: editorState.style.paddingUnit * 0.5,
            ),
            itemExtent: LayerWidget.layerHeight,

            children: [
              for (var i = canvas.elements.length - 1; i >= 0; i--)
                if (canvas.elements[i] case ElementModel element)
                  LayerWidget(key: ValueKey(element.id), element: element),
            ],
          ),
        );
      },
    );
  }
}

class LayerWidget extends StatelessWidget {
  const LayerWidget({super.key, required this.element});
  static const double layerBoundary = 20;
  static const double layerHeight = 40;
  final ElementModel element;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        RubricEditorState.of(context).edits.selectElement(element);
      },
      child: RubricContainer(
        height: layerHeight,
        width: double.infinity,
        child: element.type.layerBuilder(element: element),
      ),
    );
  }
}
