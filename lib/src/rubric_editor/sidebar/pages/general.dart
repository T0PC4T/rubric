import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/models/editor_models.dart';
import 'package:rubric/src/shared/shared.dart';

class GeneralSettingsPageWidget extends StatelessWidget {
  const GeneralSettingsPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final editorState = RubricEditorState.of(context);
    // todo, make this listen to editor
    return Column(
      spacing: editorState.style.paddingUnit,
      children: [
        RubricText("General Settings Page"),
        ValueListenableBuilder(
          valueListenable: editorState.edits,
          builder: (context, edits, child) {
            return RubricDropdown(
              items: [
                for (var grid in GridSizes.values)
                  DropdownMenuItem(value: grid, child: Text(grid.pretty)),
              ],
              onChanged: (value) {
                if (value case GridSizes value) {
                  // todo
                }
              },
            );
          },
        ),
      ],
    );
  }
}
