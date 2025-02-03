import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/rubric_editor/models/editor.dart';
import 'package:rubric/src/shared/shared.dart';

class GeneralSettingsPageWidget extends StatelessWidget {
  const GeneralSettingsPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final editorState = RubricEditorState.depend(context);
    return Column(
      spacing: editorState.style.paddingUnit,
      children: [
        RubricText("General Settings Page"),
        RubricDropdown(
          items: [
            for (var grid in GridSizes.values)
              DropdownMenuItem(value: grid, child: Text(grid.pretty)),
          ],
          onChanged: (value) {
            if (value case GridSizes value) {
              editorState.editEditor(
                editorState.edits.copyWith(gridSize: value),
              );
            }
          },
        ),
      ],
    );
  }
}
