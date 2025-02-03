import 'package:flutter/material.dart';
import 'package:rubric/src/elements/models/elements.dart';
import 'package:rubric/src/rubric_editor/models/editor.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';
import 'package:rubric/src/rubric_editor/sidebar/sidebar.dart';
import 'package:rubric/src/rubric_editor/tab_bar/element_toolbar.dart';
import 'package:rubric/src/rubric_editor/topbar/topbar.dart';
import 'package:rubric/src/rubric_editor/viewer/viewer.dart';

class RubricEditor extends StatefulWidget {
  final RubricEditorStyle style;
  final CanvasModel canvas;
  const RubricEditor({
    super.key,
    this.style = const RubricEditorStyle(),
    this.canvas = const CanvasModel(),
  });
  @override
  State<RubricEditor> createState() => RubricEditorState();
}

class RubricEditorState extends State<RubricEditor> {
  late CanvasModel canvas;
  late CanvasEditingModel edits = CanvasEditingModel();
  late RubricEditorStyle style;

  @override
  void initState() {
    super.initState();
    canvas = widget.canvas;
    style = widget.style;
  }

  saveStep() {
    setState(() {});
    // edits = edits.copyWith(
    //   selected: newElements.firstWhere((e) => e.id == element.id),
    // );
  }

  editEditor(CanvasEditingModel edits) {
    setState(() {
      this.edits = edits;
    });
  }

  changeProperties(ElementModel element, Map<String, dynamic> newPropeties) {
    setState(() {
      element.properties = newPropeties;
    });
  }

  selectElement(ElementModel? element) {
    setState(() {
      edits = edits.copyWith(selected: element);
    });
  }

  addElementAndFocus(ElementModel element) {
    setState(() {
      canvas = canvas.copyWith(
        elements: List.from(canvas.elements)..add(element),
      );
      selectElement(element);
    });
  }

  static RubricEditorState depend(BuildContext ctx) {
    ctx.dependOnInheritedWidgetOfExactType<RubricEditorInheritedWidget>();
    if (ctx.findAncestorStateOfType<RubricEditorState>()
        case RubricEditorState state) {
      return state;
    }
    throw AssertionError("RubricEditorState not found");
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
    return RubricEditorInheritedWidget(
      canvas: canvas,
      child: DefaultTextStyle(
        style: TextStyle(color: style.dark, fontSize: style.fontSize),
        child: Column(
          children: [
            TopBarWidget(),
            Expanded(
              child: Row(
                children: [
                  RubricSideBar(),
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        RubricEditorViewer(),
                        if (edits.selected case ElementModel element)
                          Positioned(
                            left: 0,
                            top: 0,
                            right: 0,
                            child: ElementToolbarWidget(element: element),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// todo make this an inherited model
class RubricEditorInheritedWidget extends InheritedWidget {
  final CanvasModel canvas;
  const RubricEditorInheritedWidget({
    super.key,
    required super.child,
    required this.canvas,
  });
  @override
  bool updateShouldNotify(RubricEditorInheritedWidget oldWidget) => true;

  static RubricEditorInheritedWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<RubricEditorInheritedWidget>()!;
  }
}
