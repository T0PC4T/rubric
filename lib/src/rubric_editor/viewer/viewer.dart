import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/models/editor_models.dart';
import 'package:rubric/src/models/elements.dart';
import 'package:rubric/src/rubric_editor/models/stack.dart';
import 'package:rubric/src/rubric_editor/viewer/items/element.dart';
import 'package:rubric/src/rubric_editor/viewer/items/focused.dart';
import 'package:rubric/src/rubric_editor/viewer/items/grid.dart';
import 'package:rubric/src/rubric_editor/viewer/items/position.dart';
import 'package:rubric/src/rubric_editor/viewer/items/scalar.dart';
import 'package:rubric/src/rubric_editor/viewer/stack/element_stack.dart';

class RubricEditorViewer extends StatefulWidget {
  const RubricEditorViewer({super.key});

  @override
  State<RubricEditorViewer> createState() => RubricEditorViewerState();
}

class RubricEditorViewerState extends State<RubricEditorViewer> {
  Offset? localHit;
  ElementModel? scaling;
  double desiredOffset = 0;
  late ScrollController _scrollController;
  late RubricEditorState editorState;
  @override
  void initState() {
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final editorState = RubricEditorState.of(context);
      editorState.canvas.addListener(_handler);
      editorState.edits.addListener(_handler);
    });
    super.initState();
  }

  @override
  void dispose() {
    editorState.canvas.removeListener(_handler);
    editorState.edits.removeListener(_handler);

    _scrollController.dispose();
    super.dispose();
  }

  Offset _getIntuitiveLocation(
    Offset stackHitOffset,
    Offset elementHitOffset,
    double tile,
    ElementModel element,
  ) {
    Offset offset =
        (stackHitOffset - elementHitOffset) + Offset(tile * 0.5, tile * 0.5);
    offset = Offset(offset.dx - offset.dx % tile, offset.dy - offset.dy % tile);
    return offset;
  }

  void _handleScale(
    RubricEditorState editorState,
    ElementModel element,
    Offset stackHitOffset,
    int scalarIndex,
  ) {
    // todo there's a smart way to do this by indexes and figuring if it is movable or not.
    final tile = editorState.edits.value.gridSize.pixelsPerLock;
    Offset loc;

    if (scalarIndex == 0) {
      loc = _getIntuitiveLocation(
        stackHitOffset,
        Offset(-ScalarWidget.scalarSize, -ScalarWidget.scalarSize),
        tile,
        element,
      );
      double width = element.width + (element.x - loc.dx);
      double height = element.height + (element.y - loc.dy);
      width = math.max(width, tile);
      height = math.max(height, tile);
      setState(() {
        editorState.canvas.moveElement(element, loc);
        editorState.canvas.scaleElement(element, Offset(width, height));
      });
      return;
    } else {
      loc = Offset(element.x, element.y);
    }

    double width =
        ((stackHitOffset.dx) - loc.dx).abs() +
        (scalarIndex == 0 ? tile * 2 : tile);
    double height =
        ((stackHitOffset.dy) - loc.dy).abs() +
        (scalarIndex == 0 ? tile * 2 : tile);

    width -= width % tile;
    height -= height % tile;

    width = math.max(width, tile);
    height = math.max(height, tile);
    setState(() {
      editorState.canvas.moveElement(element, loc);
      editorState.canvas.scaleElement(element, Offset(width, height));
    });
  }

  _handlePointerDown(PointerDownEvent event, StackEventResult result) {
    switch (result) {
      case StackEventResult(cancel: true):
        {
          editorState.edits.selectElement(null);
        }
      case StackEventResult(element: ElementModel element):
        {
          if (editorState.edits.isSelected(element)) {
            editorState.edits.focusElement(element);
          } else {
            editorState.edits.selectElement(element);
          }
        }
    }
  }

  _handlePointerUp(PointerUpEvent event, StackEventResult result) {
    print("CANCELING: ${result.cancel}");
    switch (result) {
      case StackEventResult(cancel: true):
        {
          if (editorState.edits.value.focused != null) {
            if (result.cancel) {
              editorState.edits.selectElement(null);
            }
            return;
          }
        }
      default:
        {
          editorState.canvas.commitIfChange(editorState.edits.lastStep);
        }
    }
  }

  _handlePointerMove(PointerMoveEvent event, StackEventResult result) {
    switch (result) {
      case StackEventResult(cancel: true):
        {
          return;
        }
      case StackEventResult(
        element: ElementModel element,
        stackHitOffset: Offset stackHitOffset,
        scalarIndex: int scalarIndex,
      ):
        {
          _handleScale(editorState, element, stackHitOffset, scalarIndex);
        }
      case StackEventResult(
        element: ElementModel element,
        elementHitOffset: Offset elementHitOffset,
        stackHitOffset: Offset stackHitOffset,
      ):
        {
          if (editorState.edits.value.focused == element) {
            return;
          }
          final tile = editorState.edits.value.gridSize.pixelsPerLock;
          // stack offset - element offset goes to the top left corner of the element
          // so you can add half a tile to make the movement from the center of the tile.
          final newLocation = _getIntuitiveLocation(
            stackHitOffset,
            elementHitOffset,
            tile,
            element,
          );
          if (element.x != newLocation.dx || element.y != newLocation.dy) {
            setState(() {
              editorState.canvas.moveElement(element, newLocation);
            });
          }
        }
    }
  }

  _handler() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    editorState = RubricEditorState.of(context);
    // todo calculate the actual size
    final double pageHeight = editorState.canvas.pageHeight();
    return SingleChildScrollView(
      // controller: _scrollController,
      // physics: NeverScrollableScrollPhysics(),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: SizedBox(
          width: GridSizes.pageSize,
          height: pageHeight,
          child: ValueListenableBuilder(
            valueListenable: editorState.canvas,
            builder: (context, canvas, _) {
              return RubricElementStack(
                // Todo implement again.
                onPointerSignal: (event) {
                  if (event is PointerScrollEvent) {
                    // print(event.scrollDelta);
                    // desiredOffset += event.scrollDelta.dy;
                    // desiredOffset = desiredOffset.clamp(0, pageHeight);
                    // print(desiredOffset);
                    // _scrollController.jumpTo(desiredOffset);
                    // _scrollController.animateTo(
                    //   desiredOffset,
                    //   duration: Duration(milliseconds: 100),
                    //   curve: Curves.easeInOut,
                    // );
                  }
                },
                onPointerDown: _handlePointerDown,
                onPointerMove: _handlePointerMove,

                onPointerUp: _handlePointerUp,

                onPointerHover: (event, result) {},
                key: ValueKey("ViewerStack"),
                children: [
                  CustomPaint(
                    key: ValueKey("grid"),
                    painter: GridPainter(
                      editorState.edits.value.gridSize.pixelsPerLine,
                    ),
                    size: Size.infinite,
                  ),

                  for (var element in canvas.elements)
                    if (!editorState.edits.isFocused(element))
                      ElementWidget(
                        key: ValueKey(element.id),
                        element: element,
                      ),

                  if (editorState.edits.value.focused
                      case ElementModel element) ...[
                    CancelSelectionWidget(cancels: true),
                    RubricPositioned(
                      x: element.x,
                      y: element.y,
                      width: element.width,
                      height: element.height,
                      child: CancelSelectionWidget(cancels: false),
                    ),
                    ElementWidget(key: ValueKey(element.id), element: element),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
