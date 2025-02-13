import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/models/canvas_notifier.dart';
import 'package:rubric/src/models/editor_models.dart';
import 'package:rubric/src/models/editor_notifier.dart';
import 'package:rubric/src/models/elements.dart';
import 'package:rubric/src/rubric_editor/navbar/navbar.dart';
import 'package:rubric/src/rubric_editor/sidebar/sidebar.dart';
import 'package:rubric/src/rubric_editor/toolbar/element_toolbar.dart';
import 'package:rubric/src/rubric_editor/viewer/viewer.dart';
import 'package:rubric/src/rubric_reader/size_block.dart';

class RubricEditor extends StatefulWidget {
  final RubricEditorStyle style;
  final CanvasModel? canvas;
  final Function(CanvasModel canvas) onSave;
  final Function() onLogoPressed;
  final Future<String> Function(Uint8List bytes, {String? name, String? type})
  bytesToURL;
  const RubricEditor({
    super.key,
    required this.style,
    required this.onSave,
    required this.onLogoPressed,
    required this.bytesToURL,
    this.canvas,
  });
  @override
  State<RubricEditor> createState() => RubricEditorState();
}

class RubricEditorState extends State<RubricEditor> {
  late CanvasNotifier canvas;
  late EditorNotifier edits;
  late RubricEditorStyle style;
  late FocusNode keyboardFocus;
  List<Widget> overlays = [];
  BuildContext? innerContext;

  @override
  void initState() {
    super.initState();
    canvas = CanvasNotifier(widget.canvas?.copyWith() ?? CanvasModel());
    canvas.addListener(_canvasListener);

    edits = EditorNotifier(CanvasEditingModel(steps: [canvas.clone()]));
    edits.addListener(_editorListener);
    keyboardFocus = FocusNode();
    style = widget.style;
  }

  _editorListener() {
    if (edits.value.focused == null) {
      keyboardFocus.requestFocus();
      if (edits.value.selected == null) {
        clearOverlays();
      }
    } else {
      keyboardFocus.unfocus();
    }
  }

  save() {
    widget.onSave(canvas.value);
  }

  undo() {
    if (edits.canUndo) {
      canvas.value = edits.undo().copyWith();
    }
  }

  redo() {
    if (edits.canRedo) {
      canvas.value = edits.redo().copyWith();
    }
  }

  _canvasListener() {
    // ? if this is false, the the last change was from an undo.
    if (edits.currentUndo != canvas.value) {
      edits.saveStep(canvas.clone());
    }
  }

  pushOverlay(Widget child, {int? removeToLength}) {
    if (removeToLength case int removeToLength) {
      overlays = overlays.sublist(0, removeToLength);
    }
    setState(() {
      overlays.add(child);
    });
  }

  popOverlay() {
    setState(() {
      overlays.removeLast();
    });
  }

  clearOverlays() {
    setState(() {
      overlays = [];
    });
  }

  bool previewing = false;
  togglePreview() {
    clearOverlays();
    previewing = !previewing;
  }

  @override
  void dispose() {
    canvas.removeListener(_canvasListener);
    edits.removeListener(_editorListener);
    keyboardFocus.dispose();
    canvas.dispose();
    edits.dispose();
    super.dispose();
  }

  showToolbar(ElementModel element, Widget child) {
    pushOverlay(
      ElementToolbarWidget(element: element, child: child),
      removeToLength: 0,
    );
  }

  static RubricEditorState of(BuildContext ctx) {
    if (ctx.findAncestorStateOfType<RubricEditorState>()
        case RubricEditorState state) {
      return state;
    }
    throw AssertionError("RubricEditorState not found");
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      onKeyEvent: (value) {
        if (value.logicalKey == LogicalKeyboardKey.delete) {
          if (edits.value.selected case ElementModel element) {
            edits.selectElement(null);
            canvas.deleteElement(element);
          }
        }
      },
      focusNode: keyboardFocus,
      child: SizeBlockerWidget(
        child: Stack(
          fit: StackFit.expand,
          children: [
            DefaultTextStyle(
              style: TextStyle(
                color: style.dark,
                fontSize: style.fontSize,
                fontWeight: style.fontWeight,
              ),
              child: Column(
                children: [
                  NavbarWidget(),
                  Expanded(
                    child: Row(
                      children: [
                        RubricSideBar(),
                        Expanded(
                          child:
                              previewing
                                  ? RubricReader(canvasModel: canvas.value)
                                  : RubricEditorViewer(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            for (var overlay in overlays) overlay,
          ],
        ),
      ),
    );
  }
}
