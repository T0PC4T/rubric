import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/elements/elements.dart';
import 'package:rubric/src/models/editor_models.dart';
import 'package:rubric/src/models/elements.dart';
import 'package:rubric/src/rubric_editor/models/stack.dart';
import 'package:rubric/src/rubric_editor/viewer/items/element.dart';
import 'package:rubric/src/rubric_editor/viewer/items/focused.dart';
import 'package:rubric/src/rubric_editor/viewer/items/grid.dart';
import 'package:rubric/src/rubric_editor/viewer/items/handler.dart';
import 'package:rubric/src/rubric_editor/viewer/items/position.dart';
import 'package:rubric/src/rubric_editor/viewer/stack/element_stack.dart';
import 'package:rubric/src/rubric_reader/padder.dart';
import 'package:rubric/src/utilities/uuid.dart';

class RubricEditorViewer extends StatefulWidget {
  const RubricEditorViewer({super.key});

  @override
  State<RubricEditorViewer> createState() => RubricEditorViewerState();
}

class RubricEditorViewerState extends State<RubricEditorViewer> {
  ElementModel? scaling;
  bool _dragged = false;
  late ScrollController _scrollController;
  late RubricEditorState editorState;
  @override
  void initState() {
    _scrollController =
        ScrollController()..addListener(() {
          editorState.edits.setScrollOffset(_scrollController.offset);
        });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final editorState = RubricEditorState.of(context);
      editorState.canvas.addListener(_refreshHandler);
      editorState.edits.addListener(_refreshHandler);
    });
    super.initState();
  }

  @override
  void dispose() {
    editorState.canvas.removeListener(_refreshHandler);
    editorState.edits.removeListener(_refreshHandler);

    _scrollController.dispose();
    super.dispose();
  }

  (Offset offset, Size size) _getNewElementDimensions(Offset position) {
    final tile = editorState.edits.value.gridSize.pixelsPerLine;
    final x = min(position.dx - position.dx % tile, GridSizes.pageSize - tile);
    final y = min(position.dy - position.dy % tile, GridSizes.pageSize - tile);
    final width = min(GridSizes.pageSize - x, tile * 10);
    final height = tile * 6;
    return (Offset(x, y), Size(width, height));
  }

  Offset _getIntuitiveLocation(
    Offset stackHitOffset,
    Offset elementHitOffset,
    double tile,
    ElementModel element,
  ) {
    // limit registrations
    stackHitOffset = Offset(
      min(max(stackHitOffset.dx, 0), GridSizes.pageSize),
      max(stackHitOffset.dy, 0),
    );

    Offset offset =
        (stackHitOffset - elementHitOffset) + Offset(tile * 0.5, tile * 0.5);
    double x = offset.dx - offset.dx % tile;
    double y = offset.dy - offset.dy % tile;

    return Offset(x, y);
  }

  void _handleMove(
    RubricEditorState editorState,
    ElementModel element,
    Offset stackHitOffset,
    Offset elementHitOffset,
  ) {
    final tile = editorState.edits.value.gridSize.pixelsPerLock;
    // stack offset - element offset goes to the top left corner of the element
    // so you can add half a tile to make the movement from the center of the tile.
    Offset newLocation = _getIntuitiveLocation(
      stackHitOffset,
      elementHitOffset,
      tile,
      element,
    );

    newLocation = Offset(
      newLocation.dx.clamp(0, GridSizes.pageSize - element.width),
      max(newLocation.dy, 0),
    );

    if (element.x != newLocation.dx || element.y != newLocation.dy) {
      setState(() {
        editorState.canvas.moveElement(element, newLocation);
      });
    }
  }

  void _handleScale(
    RubricEditorState editorState,
    ElementModel element,
    Offset stackHitOffset,
    int scalarIndex,
  ) {
    final tile = editorState.edits.value.gridSize.pixelsPerLock;
    bool movesX = false;
    bool movesY = false;
    switch (scalarIndex) {
      case 0:
        movesX = true;
        movesY = true;
      case 1:
        movesY = true;
      case 2:
        movesX = true;
    }
    Offset loc = _getIntuitiveLocation(
      stackHitOffset,
      switch (scalarIndex) {
        1 => Offset(element.width, 0),
        2 => Offset(0, element.height),
        3 => Offset(element.width, element.height),
        _ => Offset(0, 0),
      },
      tile,
      element,
    );

    double width;
    double height;
    double newX;
    double newY;

    if (movesX) {
      width = element.width + (element.x - loc.dx);
      newX = loc.dx;
    } else {
      width = element.width + (loc.dx - element.x);
      newX = element.x;
    }
    if (movesY) {
      height = element.height + (element.y - loc.dy);
      newY = loc.dy;
    } else {
      height = element.height + (loc.dy - element.y);
      newY = element.y;
    }

    width = max(width, editorState.edits.value.gridSize.pixelsPerLine);
    height = max(height, editorState.edits.value.gridSize.pixelsPerLine);

    if (width != element.width || height != element.height) {
      setState(() {
        editorState.canvas.moveElement(element, Offset(newX, newY));
        editorState.canvas.scaleElement(element, Offset(width, height));
      });
    }
  }

  _handlePointerDown(PointerDownEvent event, StackEventResult result) {
    if (editorState.edits.value.holding case ElementTypes element) {
      final position = event.localPosition;

      final (offset, size) = _getNewElementDimensions(position);
      editorState.canvas.addElement(
        ElementModel(
          id: newID(),
          type: element,
          x: offset.dx,
          y: offset.dy,
          width: size.width,
          height: size.height,
          properties: generateDefaultProperties(context, element),
        ),
      );
      editorState.setHolding(null);
    }
    switch (result) {
      case StackEventResult(cancel: true):
        {
          editorState.edits.selectElement(null);
        }
    }
  }

  _handlePointerUp(PointerUpEvent event, StackEventResult result) {
    switch (result) {
      case StackEventResult(cancel: true):
        {
          if (editorState.edits.value.focused != null) {
            if (result.cancel) {
              editorState.edits.selectElement(null);
            }
          }
        }
      case StackEventResult(element: ElementModel el):
        {
          if (editorState.edits.isSelected(el) && _dragged == false) {
            editorState.edits.focusElement(el);
          } else {
            editorState.edits.selectElement(el);
          }
        }
    }
    _dragged = false;
    editorState.canvas.commitIfChange(editorState.edits.lastStep);
  }

  _handlePointerMove(PointerMoveEvent event, StackEventResult result) {
    _dragged = true;
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
          _handleMove(editorState, element, stackHitOffset, elementHitOffset);
        }
    }
  }

  (Offset, Size)? bluePrintDimensions;
  _handlePointerHover(PointerHoverEvent event, StackEventResult result) {
    if (editorState.edits.value.holding case ElementTypes type) {
      setState(() {
        bluePrintDimensions = _getNewElementDimensions(event.localPosition);
      });
    } else {
      setState(() {
        bluePrintDimensions = null;
      });
    }
  }

  _refreshHandler() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    editorState = RubricEditorState.of(context);
    // todo calculate the actual size
    final double pageHeight = editorState.canvas.value.editorPageHeight();
    return SingleChildScrollView(
      controller: _scrollController,
      child: PagePadderWidget(
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: ValueListenableBuilder(
            valueListenable: editorState.canvas,
            builder: (context, canvas, _) {
              return SizedBox(
                width: GridSizes.pageSize,
                height: pageHeight,
                child: RubricElementStack(
                  // Todo implement again.
                  onPointerSignal: (event) {
                    // if (event is PointerScrollEvent) {}
                  },
                  onPointerDown: _handlePointerDown,
                  onPointerMove: _handlePointerMove,
                  onPointerUp: _handlePointerUp,
                  onPointerHover: _handlePointerHover,
                  key: ValueKey("ViewerStack"),
                  children: [
                    CustomPaint(
                      key: ValueKey("grid"),
                      painter: GridPainter(
                        backgroundColor: canvas.settings.backgroundColor,
                        pixelsPerLine:
                            editorState.edits.value.gridSize.pixelsPerLine,
                      ),
                      size: Size(GridSizes.pageSize, pageHeight),
                    ),
                    if (editorState.edits.value.focused == null)
                      CancelSelectionWidget(
                        key: ValueKey("canceller"),
                        cancels: true,
                        amount: 0,
                      ),
                    for (var element in canvas.elements)
                      if (!editorState.edits.isFocused(element)) ...[
                        ElementWidget(
                          key: ValueKey(element.id),
                          element: element,
                        ),
                        ElementHandlerWidget(
                          key: ValueKey("${element.id} handler"),
                          element: element,
                        ),
                      ],
                    if (editorState.edits.value.holding
                        case ElementTypes elementType)
                      if (bluePrintDimensions case (Offset offset, Size size))
                        RubricPositioned(
                          x: offset.dx,
                          y: offset.dy,
                          width: size.width,
                          height: size.height,
                          child: IgnorePointer(
                            child: ColoredBox(
                              color: editorState.style.theme.withAlpha(50),
                            ),
                          ),
                        ),
                    if (editorState.edits.value.focused
                        case ElementModel element) ...[
                      CancelSelectionWidget(
                        key: ValueKey("canceller"),
                        cancels: true,
                      ),
                      RubricPositioned(
                        x: element.x,
                        y: element.y,
                        width: element.width,
                        height: element.height,
                        child: CancelSelectionWidget(cancels: false),
                      ),
                      ElementWidget(
                        key: ValueKey(element.id),
                        element: element,
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
