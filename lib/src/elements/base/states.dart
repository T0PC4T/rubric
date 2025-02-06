import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';

abstract class SelectableState<T extends StatefulWidget> extends State<T> {
  late RubricEditorState editorState;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(postFrame);
    super.initState();
  }

  postFrame(_) {
    editorState = RubricEditorState.of(context);
    editorState.edits.selectionNotifier.addListener(onSelect);
  }

  onSelect();

  @override
  void dispose() {
    editorState.edits.selectionNotifier.removeListener(onSelect);
    super.dispose();
  }
}

abstract class SelectableAndFocusableState<T extends StatefulWidget>
    extends State<T> {
  late RubricEditorState editorState;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(postFrame);
    super.initState();
  }

  postFrame(_) {
    editorState = RubricEditorState.of(context);
    editorState.edits.selectionNotifier.addListener(onSelect);
    editorState.edits.focusNotifier.addListener(onFocus);
  }

  onSelect();
  onFocus();

  @override
  void dispose() {
    editorState.edits.selectionNotifier.removeListener(onSelect);
    editorState.edits.focusNotifier.removeListener(onFocus);
    super.dispose();
  }
}
