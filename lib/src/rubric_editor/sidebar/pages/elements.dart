import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/elements/box/model_box.dart';
import 'package:rubric/src/models/elements.dart';
import 'package:rubric/src/rubric_editor/sidebar/sidebar.dart';
import 'package:rubric/src/shared/atoms/button.dart';

class ElementPageWidget extends StatelessWidget {
  const ElementPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final editorState = RubricEditorState.depend(context);
    final tile = editorState.edits.gridSize.pixelsPerLine.toDouble();
    return Wrap(
      children: [
        for (var element in ElementTypes.values)
          RubricButton(
            padding: EdgeInsets.all(15),

            backgroundColor: editorState.style.backgroundColor,
            width: RubricSideBar.sideBarSize * 0.5,
            height: RubricSideBar.sideBarSize * 0.5,
            hoverColor:
                Color.lerp(
                  editorState.style.primaryColor,
                  editorState.style.backgroundColor,
                  0.4,
                )!,
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
            child: Row(children: [Icon(element.icon), Text(element.name)]),
          ),
      ],
    );
  }
}
