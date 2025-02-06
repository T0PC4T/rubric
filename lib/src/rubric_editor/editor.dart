import 'package:flutter/material.dart';
import 'package:rubric/src/models/canvas.dart';
import 'package:rubric/src/models/editor_models.dart';
import 'package:rubric/src/models/elements.dart';
import 'package:rubric/src/models/notifier.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';
import 'package:rubric/src/rubric_editor/navbar/navbar.dart';
import 'package:rubric/src/rubric_editor/sidebar/sidebar.dart';
import 'package:rubric/src/rubric_editor/toolbar/element_toolbar.dart';
import 'package:rubric/src/rubric_editor/viewer/viewer.dart';

class RubricEditor extends StatefulWidget {
  final RubricEditorStyle style;
  final CanvasModel? canvas;
  const RubricEditor({
    super.key,
    this.style = const RubricEditorStyle(),
    this.canvas,
  });
  @override
  State<RubricEditor> createState() => RubricEditorState();
}

class RubricEditorState extends State<RubricEditor> {
  late CanvasNotifier canvas;
  late EditorNotifier edits;
  late RubricEditorStyle style;
  OverlayEntry? currentBar;
  late BuildContext innerContext;
  @override
  void initState() {
    super.initState();
    // print(cav.elements.hashCode);
    // print(cav.copyWith().elements.hashCode);

    canvas = CanvasNotifier(widget.canvas?.copyWith() ?? CanvasModel())
      ..addListener(_saveStep);
    edits = EditorNotifier(CanvasEditingModel(steps: [canvas.clone()]));
    style = widget.style;
  }

  undo() {
    edits.clear();
    canvas.value = edits.lastStep;
  }

  _saveStep() {
    edits.saveStep(canvas.clone());
    // print(edits.value.steps);
  }

  removeToolbar() {
    currentBar?.remove();
    currentBar?.dispose();
    currentBar = null;
  }

  showToolbar(ElementModel element, {Widget? child}) {
    removeToolbar();
    currentBar = OverlayEntry(
      canSizeOverlay: true,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(top: NavbarWidget.navbarHeight),
          alignment: Alignment.topCenter,
          child: ElementToolbarWidget(element: element, child: child),
        );
      },
    );
    Overlay.of(innerContext).insert(currentBar!);
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
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (ctx) {
            innerContext = ctx;
            return DefaultTextStyle(
              style: TextStyle(color: style.dark, fontSize: style.fontSize),
              child: Column(
                children: [
                  NavbarWidget(),
                  Expanded(
                    child: Row(
                      children: [
                        RubricSideBar(),
                        Expanded(child: RubricEditorViewer()),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
