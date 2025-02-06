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
    final imageProperties = widget.element.getProperties<ImageElementModel>();
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageProperties.imageUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(imageProperties.borderRadius),
      ),
    );
  }
}

class ImageLayerWidget extends StatelessWidget {
  final ElementModel element;
  const ImageLayerWidget({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    final imageProperties = element.getProperties<ImageElementModel>();
    return Image.network(imageProperties.imageUrl);
  }
}
