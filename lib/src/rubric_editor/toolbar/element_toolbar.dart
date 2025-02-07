import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/models/elements.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';

class ElementToolbarWidget extends StatelessWidget {
  final ElementModel element;
  final Widget? child;
  static const double elementToolbarHeight = 40;
  static const double iconSize = 25;
  const ElementToolbarWidget({super.key, required this.element, this.child});

  @override
  Widget build(BuildContext context) {
    final style = RubricEditorStyle.of(context);
    final editorState = RubricEditorState.of(context);
    final bool isFocused = editorState.edits.value.focused == element;

    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(RubricEditorStyle.paddingUnit * 2),
      height: elementToolbarHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: style.borderRadius,
        boxShadow: [
          BoxShadow(
            color: style.dark.withAlpha(50),
            blurRadius: style.elevation,
            offset: Offset(0, style.elevation), // changes position of shadow
          ),
        ],
      ),
      child: child,
    );
  }
}
