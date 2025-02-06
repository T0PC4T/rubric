import 'package:flutter/material.dart';
import 'package:rubric/src/elements/base/states.dart';
import 'package:rubric/src/elements/box/box_model.dart';
import 'package:rubric/src/elements/box/box_tooltip.dart';
import 'package:rubric/src/models/elements.dart';

class BoxEditorElement extends StatefulWidget {
  final ElementModel element;
  const BoxEditorElement({super.key, required this.element});

  @override
  State<BoxEditorElement> createState() => BoxEditorElementState();
}

class BoxEditorElementState extends SelectableState<BoxEditorElement> {
  @override
  onSelect() {
    if (editorState.edits.isSelected(widget.element)) {
      editorState.showToolbar(
        widget.element,
        child: BoxTooltipWidget(element: widget.element),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final boxElement = widget.element.getProperties<BoxElementModel>();
    return Container(
      decoration: BoxDecoration(
        color: boxElement.color,
        borderRadius: BorderRadius.circular(boxElement.borderRadius),
      ),
    );
  }
}
