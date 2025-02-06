import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
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
  late QuillController controller;
  late ScrollController _scrollController;
  late FocusNode focusNode;
  late RubricEditorState editorState;

  @override
  void initState() {
    final textElement = widget.element.getProperties<TextElementModel>();
    focusNode = FocusNode();
    _scrollController = ScrollController();
    controller = QuillController(
      document: textElement.document,
      selection: TextSelection(baseOffset: 0, extentOffset: 0),
      readOnly: false,
      editorFocusNode: focusNode,

      configurations: QuillControllerConfigurations(),
    );
    controller.addListener(_onChange);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // todo
      editorState.edits.focusNotifier.addListener(_onFocus);
      _onFocus();
    });

    super.initState();
  }

  void _onFocus() {
    if (editorState.edits.isFocused(widget.element)) {
      controller.readOnly = false;
      editorState.showToolbar(
        widget.element,
        child: TextTooltipWidget(
          element: widget.element,
          controller: controller,
        ),
      );
      focusNode.requestFocus();
    } else {
      focusNode.unfocus();
      controller.readOnly = true;
      editorState.removeToolbar();
      editorState.canvas.updateElement(
        widget.element,
        TextElementModel(document: controller.document).toJson(),
      );
    }
  }

  void _onChange() {}

  @override
  void dispose() {
    _scrollController.dispose();
    controller.dispose();
    focusNode.dispose();
    editorState.edits.focusNotifier.removeListener(_onFocus);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    editorState = RubricEditorState.of(context);
    return QuillEditor(
      scrollController: _scrollController,
      controller: controller,
      focusNode: focusNode,
      configurations: QuillEditorConfigurations(),
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
