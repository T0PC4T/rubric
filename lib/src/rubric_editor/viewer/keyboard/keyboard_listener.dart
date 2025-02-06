import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/elements/base/states.dart';
import 'package:rubric/src/models/elements.dart';

class RubricKeyboardListenerWidget extends StatefulWidget {
  final Widget child;
  const RubricKeyboardListenerWidget({super.key, required this.child});

  @override
  State<RubricKeyboardListenerWidget> createState() =>
      RubricKeyboardListenerWidgetState();
}

class RubricKeyboardListenerWidgetState
    extends SelectableState<RubricKeyboardListenerWidget> {
  late FocusNode focusNode;
  @override
  void initState() {
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editorState = RubricEditorState.of(context);
    return KeyboardListener(
      focusNode: focusNode,
      child: widget.child,
      onKeyEvent: (value) {
        // if key is delete key

        if (value.logicalKey == LogicalKeyboardKey.delete) {
          if (editorState.edits.value.selected case ElementModel element) {
            editorState.edits.selectElement(null);
            editorState.canvas.deleteElement(element);
          }
        }
      },
    );
  }

  @override
  postFrame(x) {
    focusNode.requestFocus();
    return super.postFrame(x);
  }

  @override
  onSelect() {
    final editorState = RubricEditorState.of(context);
    if (editorState.edits.value.selected == null) {
      focusNode.requestFocus();
    }
  }
}
