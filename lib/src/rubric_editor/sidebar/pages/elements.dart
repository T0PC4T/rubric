import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/elements/box/box_model.dart';
import 'package:rubric/src/elements/models/elements.dart';
import 'package:rubric/src/rubric_editor/sidebar/sidebar.dart';
import 'package:rubric/src/shared/atoms/button.dart';

class ElementPageWidget extends StatelessWidget {
  const ElementPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonSize = RubricSideBar.sideBarSize * 0.5;
    final editorState = RubricEditorState.depend(context);
    final tile = editorState.edits.gridSize.pixelsPerLine.toDouble();
    return Wrap(
      children: [
        for (var element in ElementTypes.values)
          RubricButton(
            padding: EdgeInsets.all(15),

            backgroundColor: editorState.style.light,
            width: buttonSize,
            height: buttonSize,
            hoverColor: editorState.style.primary4,
            onTap: () {
              final state = RubricEditorState.depend(context);
              state.addElementAndFocus(
                ElementModel(
                  id: UniqueKey().toString(),
                  type: element,
                  x: tile,
                  y: tile * 4,
                  width: tile,
                  height: tile,
                  properties:
                      BoxElementModel(
                        color: const Color.fromARGB(255, 114, 227, 255),
                      ).toJson(),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              spacing: editorState.style.paddingUnit * 0.5,
              children: [
                Icon(element.icon, size: buttonSize * 0.4),
                Text(element.name),
              ],
            ),
          ),
      ],
    );
  }
}
