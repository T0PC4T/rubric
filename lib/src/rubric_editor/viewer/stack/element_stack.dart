import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rubric/src/elements/models/elements.dart';
import 'package:rubric/src/rubric_editor/models/stack.dart';
import 'package:rubric/src/rubric_editor/viewer/items/element.dart';
import 'package:rubric/src/rubric_editor/viewer/items/scalar.dart';
import 'package:rubric/src/rubric_editor/viewer/stack/parent_data.dart';

typedef PointerUpElement =
    void Function(PointerUpEvent event, StackEventResult result);

typedef PointerDownElement =
    void Function(PointerDownEvent event, StackEventResult result);

typedef PointerMoveElement =
    void Function(PointerMoveEvent event, StackEventResult result);

typedef PointerHoverElement =
    void Function(PointerHoverEvent event, StackEventResult result);

// this widget manages stacking elements allowing for hittesting to be done at the level of Renderobject. Similar to Stack widget but more simple
class RubricElementStack extends MultiChildRenderObjectWidget {
  final PointerSignalEventListener onPointerSignal;
  final PointerUpElement onPointerUp;
  final PointerDownElement onPointerDown;
  final PointerMoveElement onPointerMove;
  final PointerHoverElement onPointerHover;
  const RubricElementStack({
    super.key,
    super.children,
    required this.onPointerSignal,
    required this.onPointerUp,
    required this.onPointerDown,
    required this.onPointerMove,
    required this.onPointerHover,
  });

  @override
  RenderRubricElementStack createRenderObject(BuildContext context) {
    return RenderRubricElementStack(
      onPointerSignal: onPointerSignal,
      onPointerUp: onPointerUp,
      onPointerDown: onPointerDown,
      onPointerMove: onPointerMove,
      onPointerHover: onPointerHover,
    );
  }
}

class RenderRubricElementStack extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, RuPositionParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, RuPositionParentData> {
  /// Creates a stack render object.
  ///
  /// By default, the non-positioned children of the stack are aligned by their
  /// top left corners.
  final PointerSignalEventListener onPointerSignal;
  final PointerUpElement onPointerUp;
  final PointerDownElement onPointerDown;
  final PointerMoveElement onPointerMove;
  final PointerHoverElement onPointerHover;

  RenderRubricElementStack({
    List<RenderBox>? children,
    required this.onPointerSignal,
    required this.onPointerUp,
    required this.onPointerDown,
    required this.onPointerMove,
    required this.onPointerHover,
  }) {
    addAll(children);
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! RuPositionParentData) {
      child.parentData =
          RuPositionParentData()
            ..x = 0
            ..y = 0
            ..width = double.infinity
            ..height = double.infinity;
    }
  }

  @override
  void performLayout() {
    assert(
      constraints.hasBoundedHeight || constraints.hasBoundedWidth,
      "Rubric stack requires max width & max height",
    );
    size = constraints.biggest;
    RenderBox? child = firstChild;
    while (child != null) {
      if (child.parentData case RuPositionParentData childParentData) {
        final BoxConstraints childConstraints = childParentData
            .positionedChildConstraints(size);
        child.layout(childConstraints, parentUsesSize: true);

        childParentData.offset = Offset(
          childParentData.x ?? 0,
          childParentData.y ?? 0,
        );
        child = childParentData.nextSibling;
      }
    }
  }

  ElementModel? _mouseDownHit;
  Offset? _elementHitOffset;
  Offset _stackHitOffset = Offset.zero;
  int? _scalarIndex;

  StackEventResult getEventResult(PointerEvent event, HitTestEntry entry) {
    final localPosition = globalToLocal(event.position);
    _stackHitOffset = localPosition;
    if (event is PointerDownEvent) {
      final BoxHitTestResult result = BoxHitTestResult();
      final hit = hitTest(result, position: localPosition);
      if (hit) {
        for (var result in result.path) {
          if (result.target case ElementRenderProxyBox target) {
            _elementHitOffset = target.globalToLocal(event.position);
            _mouseDownHit = target.element;
            return StackEventResult(
              element: _mouseDownHit,
              elementHitOffset: _elementHitOffset,
              stackHitOffset: _stackHitOffset,
            );
          } else if (result.target case ScalarRenderProxyBox target) {
            _elementHitOffset = target.globalToLocal(event.position);
            _mouseDownHit = target.element;
            _scalarIndex = target.scalarIndex;
            return StackEventResult(
              element: _mouseDownHit,
              elementHitOffset: _elementHitOffset,
              stackHitOffset: _stackHitOffset,
              scalarIndex: target.scalarIndex,
            );
          }
        }
      }
      return StackEventResult(stackHitOffset: _stackHitOffset);
    }
    // its not a pointer down,
    final result = StackEventResult(
      stackHitOffset: _stackHitOffset,
      element: _mouseDownHit,
      elementHitOffset: _elementHitOffset,
      scalarIndex: _scalarIndex,
    );
    if (event is PointerUpEvent) {
      _mouseDownHit = null;
      _elementHitOffset = null;
      _scalarIndex = null;
    }
    return result;
  }

  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    final result = getEventResult(event, entry);

    return switch (event) {
      PointerSignalEvent() => onPointerSignal.call(event),
      PointerUpEvent() => onPointerUp.call(event, result),
      PointerDownEvent() => onPointerDown.call(event, result),
      PointerMoveEvent() => onPointerMove.call(event, result),
      PointerHoverEvent() => onPointerHover.call(event, result),
      // PointerCancelEvent() => onPointerCancel?.call(event), // ? this might be useful.
      _ => null,
    };
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    // ? always hit the canvas even if it is empty
    result.add(BoxHitTestEntry(this, position));
    return defaultHitTestChildren(result, position: position);

    // return r;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // context.canvas.save();
    // context.canvas.translate(offset.dx, offset.dy);
    // paintGrid(context.canvas);
    // context.canvas.restore();

    // todo you can optimize this to not paint all the children.
    defaultPaint(context, offset);
  }
}
