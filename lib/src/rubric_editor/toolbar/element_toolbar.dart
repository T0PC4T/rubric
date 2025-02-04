import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/elements/models/elements.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';
import 'package:rubric/src/shared/shared.dart';

class ElementToolbarWidget extends StatelessWidget {
  final ElementModel element;
  final Widget? child;
  static const double elementToolbarHeight = 35;
  const ElementToolbarWidget({super.key, required this.element, this.child});

  @override
  Widget build(BuildContext context) {
    final style = RubricEditorStyle.of(context);
    final editorState = RubricEditorState.of(context);
    final bool isFocused = editorState.edits.focused == element;

    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(style.paddingUnit * 2),
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
      child: Row(
        spacing: style.paddingUnit * 0.5,
        mainAxisSize: MainAxisSize.min,
        children: [
          RubricButton(
            padding: EdgeInsets.all(editorState.style.paddingUnit * 0.5),
            onTap: () {
              if (isFocused) {
                editorState.selectElement(element);
              } else {
                editorState.focusElement(element);
              }
            },
            child: Row(
              children: [
                isFocused ? Icon(Icons.arrow_forward) : Icon(Icons.edit),
                isFocused ? RubricText("Move") : RubricText("Edit"),
              ],
            ),
          ),
          VerticalDivider(width: 1, color: style.light6),
          if (child case Widget child) ...[
            child,
            VerticalDivider(width: 1, color: style.light6),
          ],
          RubricIconButton(
            size: ElementToolbarWidget.elementToolbarHeight,
            onTap: () {
              editorState.selectElement(null);
              editorState.canvas.deleteElement(element);
              editorState.saveStep();
            },
            iconData: Icons.delete,
          ),
        ],
      ),
    );
  }
}
