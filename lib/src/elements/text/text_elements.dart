import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/elements/text/text_model.dart';
import 'package:rubric/src/elements/text/text_tooltip.dart';
import 'package:rubric/src/models/elements.dart';
import 'package:rubric/src/rubric_editor/sidebar/pages/layers.dart';

class TextEditorElement extends StatefulWidget {
  final ElementModel element;
  const TextEditorElement({super.key, required this.element});

  @override
  State<TextEditorElement> createState() => TextEditorElementState();
}

class TextEditorElementState extends State<TextEditorElement> {
  late FleatherController controller;
  late FocusNode focusNode;
  late RubricEditorState editorState;

  @override
  void initState() {
    final textElement = widget.element.getProperties<TextElementModel>();
    focusNode = FocusNode();
    controller = FleatherController(document: textElement.document);
    controller.addListener(_onChange);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (editorState.edits.isFocused(widget.element)) {
        focusNode.requestFocus();
        editorState.showToolbar(
          widget.element,
          child: TextTooltipWidget(
            element: widget.element,
            controller: controller,
          ),
        );
      }
    });
    super.initState();
  }

  void _onChange() {
    editorState.canvas.updateElement(
      widget.element,
      TextElementModel(document: controller.document).toJson(),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    editorState = RubricEditorState.of(context);
    final editable = editorState.edits.isFocused(widget.element);

    if (!editable) {
      focusNode.unfocus();
    }
    return FleatherEditor(
      focusNode: focusNode,
      padding: const EdgeInsets.all(16),
      readOnly: !editable,
      scrollable: false,
      enableInteractiveSelection: editable,
      controller: controller,
    );
  }
}

class TextLayerWidget extends StatelessWidget {
  final ElementModel element;
  const TextLayerWidget({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    final textElement = element.getProperties<TextElementModel>();
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,

      child: Padding(
        padding: const EdgeInsets.only(right: LayerWidget.layerHeight),
        child: Text(
          textElement.document.toPlainText(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
