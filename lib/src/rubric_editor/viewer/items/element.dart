import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/models/elements.dart';
import 'package:rubric/src/rubric_editor/viewer/items/handler.dart';
import 'package:rubric/src/rubric_editor/viewer/items/position.dart';

class ElementWidget extends StatelessWidget {
  final ElementModel element;
  const ElementWidget({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    final editorState = RubricEditorState.of(context);
    final selected = editorState.edits.value.selected == element;
    final focused = editorState.edits.value.focused == element;

    ElementBuilderFunction builder;
    if (selected) {
      builder = ElementHandlerWidget.new;
    } else if (focused) {
      builder = element.type.focusBuilder;
    } else {
      builder =
          ({Key? key, required ElementModel element}) => AbsorbPointer(
            child: element.type.editorBuilder(element: element, key: key),
          );
    }
    return RubricPositioned.fromElement(
      element: element,
      child: ElementRenderObjectWidget(
        focused: editorState.edits.value.focused == element,
        element: element,
        child: builder(element: element),
      ),
    );
  }
}

class ElementRenderProxyBox extends RenderProxyBox {
  ElementModel element;
  bool focused;

  ElementRenderProxyBox({
    RenderBox? child,
    required this.element,
    required this.focused,
  }) : super(child);
}

class ElementRenderObjectWidget extends SingleChildRenderObjectWidget {
  final ElementModel element;
  final bool focused;

  const ElementRenderObjectWidget({
    super.key,
    required this.element,
    required this.focused,
    required super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return ElementRenderProxyBox(element: element, focused: focused);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    ElementRenderProxyBox renderObject,
  ) {
    // if (renderObject.element != element) {
    renderObject.element = element;
    renderObject.focused = focused;
    renderObject.markNeedsLayout();
    // }
  }
}
