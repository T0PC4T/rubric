import 'package:rubric/src/rubric_editor/editor.dart';

abstract class InteractiveElementWidget {
  onSelect(RubricEditorState editorState);
  onFocus(RubricEditorState editorState);
}
