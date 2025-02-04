import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rubric/src/elements/models/elements.dart';

class ScalarRenderProxyBox extends RenderProxyBox {
  int scalarIndex;
  ElementModel element;
  ScalarRenderProxyBox({
    RenderBox? child,
    required this.element,
    required this.scalarIndex,
  }) : super(child);
}

// Example usage in a widget

class ScalarWidget extends StatelessWidget {
  final ElementModel element;
  final int scalarIndex;
  const ScalarWidget({
    super.key,
    required this.element,
    required this.scalarIndex,
  });

  static const double scalarSize = 10;
  @override
  Widget build(BuildContext context) {
    return ScalarRenderWidget(
      element: element,
      scalarIndex: scalarIndex,
      child: Container(
        width: scalarSize,
        height: scalarSize,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.black),
        ),
      ),
    );
  }
}

class ScalarRenderWidget extends SingleChildRenderObjectWidget {
  final ElementModel element;
  final int scalarIndex;
  const ScalarRenderWidget({
    super.key,
    required this.element,
    required this.scalarIndex,
    required super.child,
  });

  @override
  void updateRenderObject(
    BuildContext context,
    ScalarRenderProxyBox renderObject,
  ) {
    renderObject.element = element;
    super.updateRenderObject(context, renderObject);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    return ScalarRenderProxyBox(element: element, scalarIndex: scalarIndex);
  }
}
