import 'package:flutter/material.dart';
import 'package:rubric/src/elements/base/states.dart';
import 'package:rubric/src/elements/image/image_model.dart';
import 'package:rubric/src/elements/image/image_tooltip.dart';
import 'package:rubric/src/models/elements.dart';

class ImageEditorElement extends StatefulWidget {
  final ElementModel element;
  const ImageEditorElement({super.key, required this.element});

  @override
  State<ImageEditorElement> createState() => ImageEditorElementState();
}

class ImageEditorElementState extends SelectableState<ImageEditorElement> {
  @override
  onSelect() {
    if (editorState.edits.isSelected(widget.element)) {
      editorState.showToolbar(
        widget.element,
        child: ImageTooltipWidget(element: widget.element),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final boxElement = widget.element.getProperties<ImageElementModel>();
    return Container(
      decoration: BoxDecoration(
        // color: boxElement.color,
        borderRadius: BorderRadius.circular(boxElement.borderRadius),
      ),
    );
  }
}
