import 'package:flutter/material.dart';
import 'package:rubric/src/elements/models/elements.dart';
import 'package:rubric/src/rubric_editor/models/editor.dart';
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
  late CanvasModel canvas;
  late CanvasEditingModel edits = CanvasEditingModel();
  late RubricEditorStyle style;
  OverlayEntry? currentBar;
  late BuildContext innerContext;
  @override
  void initState() {
    super.initState();
    canvas = widget.canvas ?? CanvasModel();
    style = widget.style;
  }

  saveStep() {
    final newElements = List<CanvasModel>.from(edits.steps);
    setState(() {
      edits = edits.copyWith(steps: newElements..add(canvas));
      canvas = canvas.copyWith();
    });
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

  selectElement(ElementModel? element) {
    setState(() {
      edits = edits.copyWith(selected: element, focused: null);
    });
    if (edits.selected case ElementModel element) {
      showToolbar(element);
    } else {
      removeToolbar();
    }
  }

  focusElement(ElementModel element) {
    setState(() {
      edits = edits.copyWith(selected: null, focused: element);
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
      child: Overlay(
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
