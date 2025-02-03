import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/elements/models/elements.dart';
import 'package:rubric/src/rubric_editor/models/editor.dart';
import 'package:rubric/src/rubric_editor/models/stack.dart';
import 'package:rubric/src/rubric_editor/viewer/items/element.dart';
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

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
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
    final tile = editorState.edits.gridSize.pixelsPerLine;
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

  @override
  Widget build(BuildContext context) {
    final editorState = RubricEditorState.depend(context);
    // todo calculate the actual size
    final double pageHeight = 2000;
    return SingleChildScrollView(
      // controller: _scrollController,
      // physics: NeverScrollableScrollPhysics(),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: SizedBox(
          width: GridSizes.pageSize,
          height: pageHeight,
          child: RubricElementStack(
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
            onPointerDown: (event, result) {
              editorState.selectElement(result.element);
            },
            onPointerMove: (event, result) {
              if (result case StackEventResult(
                element: ElementModel element,
                stackHitOffset: Offset stackHitOffset,
                scalarIndex: int scalarIndex,
              )) {
                _handleScale(editorState, element, stackHitOffset, scalarIndex);
              } else if (result case StackEventResult(
                element: ElementModel element,
                elementHitOffset: Offset elementHitOffset,
                stackHitOffset: Offset stackHitOffset,
              )) {
                final tile = editorState.edits.gridSize.pixelsPerLine;
                // stack offset - element offset goes to the top left corner of the element
                // so you can add half a tile to make the movement from the center of the tile.
                final newLocation = _getIntuitiveLocation(
                  stackHitOffset,
                  elementHitOffset,
                  tile,
                  element,
                );
                if (element.x != newLocation.dx ||
                    element.y != newLocation.dy) {
                  setState(() {
                    editorState.canvas.moveElement(element, newLocation);
                  });
                }
              }
            },
            onPointerUp: (event, result) {},
            onPointerHover: (event, result) {},
            key: ValueKey("ViewerStack"),
            children: [
              if (editorState.edits.gridSize != GridSizes.none)
                RubricPositioned(
                  key: ValueKey("background"),
                  height: double.infinity,
                  width: double.infinity,
                  x: 0,
                  y: 0,
                  child: CustomPaint(
                    key: ValueKey("grid"),
                    painter: GridPainter(
                      editorState.edits.gridSize.pixelsPerLine,
                    ),
                    size: Size.infinite,
                  ),
                ),

              for (var element in editorState.canvas.elements)
                ElementWidget(key: ValueKey(element.id), element: element),
              if (editorState.edits.selected case ElementModel element) ...[
                ScalarWidget(element: element, scalarIndex: 0),
                ScalarWidget(element: element, scalarIndex: 1),
              ],
            ],
          ),
        ),
      ),
    );
  }
}




// Listener(
//       onPointerSignal: (event) {
//         if (event is PointerScrollEvent) {
//           final delta = event.scrollDelta;
//           setState(() {
//             state.edits = state.edits.copyWith(
//               viewOffset: state.edits.viewOffset + delta.dy,
//             );
//           });
//         }
//       },
//       onPointerDown: (event) {
//         final box = context.findRenderObject() as RenderBox;
//         final localPosition = box.globalToLocal(event.position);
//         final BoxHitTestResult result = BoxHitTestResult();
//         final hit = box.hitTest(result, position: localPosition);
//         if (hit) {
//           for (var result in result.path) {
//             if (result.target is ElementRenderProxyBox) {
//               localHit = (result.target as RenderBox).globalToLocal(
//                 event.position,
//               );
//               state.selectElement(
//                 (result.target as ElementRenderProxyBox).element,
//               );
//               return;
//             }
//             if (result.target is ScalarRenderProxyBox) {
//               final element = (result.target as ScalarRenderProxyBox).element;
//               scaling = element;
//               state.selectElement(element);
//               localHit = (result.target as RenderBox).globalToLocal(
//                 event.position,
//               );
//               return;
//             }
//           }
//         }
//         state.selectElement(null);
//       },
//       onPointerUp: (event) {
//         state.saveStep();
//         scaling = null;
//         localHit = null;
//       },
//       onPointerMove: (event) {
//         final state = RubricEditorState.of(context);
//         if ((scaling, localHit) case (ElementModel element, Offset hit)) {
//           final tile = state.edits.gridSize.getCell(1);
//           double width = ((event.localPosition.dx) - element.x);
//           double height =
//               ((event.localPosition.dy) - element.y) + state.edits.viewOffset;

//           width -= width % tile;
//           height -= height % tile;

//           width = math.max(width, tile);
//           height = math.max(height, tile);
//           setState(() {
//             state.canvas.scaleElement(element, Offset(width, height));
//           });
//         } else if ((state.edits.selected, localHit) case (
//           ElementModel element,
//           Offset hit,
//         )) {
//           setState(() {
//             final tile = state.edits.gridSize.getCell(1);
//             Offset newLocation =
//                 (event.localPosition - hit) + Offset(0, state.edits.viewOffset);

//             newLocation = Offset(
//               newLocation.dx - newLocation.dx % tile,
//               newLocation.dy - newLocation.dy % tile,
//             );

//             state.canvas.moveElement(element, newLocation);
//           });
//         }
//       },