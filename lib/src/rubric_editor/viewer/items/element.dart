import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rubric/src/elements/models/elements.dart';
import 'package:rubric/src/rubric_editor/viewer/items/position.dart';

class ElementRenderProxyBox extends RenderProxyBox {
  ElementModel element;

  ElementRenderProxyBox({RenderBox? child, required this.element})
    : super(child);
}

class ElementWidget extends StatelessWidget {
  final ElementModel element;
  const ElementWidget({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    return RubricPositioned(
      x: element.x,
      y: element.y,
      width: element.width,
      height: element.height,
      child: ElementRenderObjectWidget(
        element: element,
        child: element.type.editorBuilder(element: element),
      ),
    );
  }
}

class ElementRenderObjectWidget extends SingleChildRenderObjectWidget {
  final ElementModel element;

  const ElementRenderObjectWidget({
    super.key,
    required this.element,
    required super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return ElementRenderProxyBox(element: element);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    ElementRenderProxyBox renderObject,
  ) {
    // if (renderObject.element != element) {
    renderObject.element = element;
    renderObject.markNeedsLayout();
    // }
  }
}
