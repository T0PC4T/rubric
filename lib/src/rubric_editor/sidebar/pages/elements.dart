import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/elements/box/box_model.dart';
import 'package:rubric/src/elements/text/text_model.dart';
import 'package:rubric/src/models/editor_models.dart';
import 'package:rubric/src/models/elements.dart';
import 'package:rubric/src/rubric_editor/sidebar/sidebar.dart';
import 'package:rubric/src/shared/atoms/button.dart';

class ElementPageWidget extends StatelessWidget {
  const ElementPageWidget({super.key});

  // TODO move this into element file.
  Map<String, dynamic> _getDefaultForType(
    BuildContext context,
    ElementTypes elementType,
  ) {
    return switch (elementType) {
      ElementTypes.box => BoxElementModel(color: Colors.green).toJson(),
      ElementTypes.text =>
        TextElementModel(document: ParchmentDocument()).toJson(),
      _ => throw "Not implemented properties for this type",
    };
  }

  @override
  Widget build(BuildContext context) {
    final buttonSize = RubricSideBar.sideBarSize * 0.5;
    final editorState = RubricEditorState.of(context);
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
              final editorState = RubricEditorState.of(context);
              final width = GridSizes.pageSize * 0.5;
              final height = GridSizes.pageSize * 0.35;
              final tile = editorState.edits.value.gridSize.pixelsPerLock;
              editorState.canvas.addElement(
                ElementModel(
                  id: UniqueKey().toString(),
                  type: element,
                  x: tile,
                  y: tile * 4,
                  width: width - (width % tile),
                  height: height - (height % tile),
                  properties: _getDefaultForType(context, element),
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
