import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/components/atoms/popup.dart';
import 'package:rubric/src/components/molecules/color_picker.dart';
import 'package:rubric/src/components/shared.dart';

class GeneralSettingsPageWidget extends StatelessWidget {
  const GeneralSettingsPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final editorState = RubricEditorState.of(context);
    // todo, make this listen to editor
    return ValueListenableBuilder(
      valueListenable: editorState.canvas,
      builder: (context, canvas, child) {
        return Padding(
          padding: editorState.style.padding,
          child: Column(
            spacing: editorState.style.paddingD,
            children: [
              Row(
                children: [
                  RubricColorButton(
                    color: canvas.settings.backgroundColor,
                    onTap: () async {
                      final newColor = await PopupWidget.showPopup<Color>(
                        context,
                        (closeWith) {
                          return RubricColorPicker(
                            onComplete: closeWith,
                            color: canvas.settings.backgroundColor,
                          );
                        },
                      );
                      if (newColor == null) return;
                      editorState.canvas.updateSettings(
                        canvas.settings.copyWith(backgroundColor: newColor),
                      );
                    },
                  ),
                  RubricText("Background Color"),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
