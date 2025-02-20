import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/components/shared.dart';
import 'package:rubric/src/rubric_editor/models/preview.dart';

class NavbarWidget extends StatelessWidget {
  static const double navbarHeight = 50;
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final editorState = RubricEditorState.of(context);
    final style = RubricEditorStyle.of(context);

    return ColoredBox(
      color: style.dark,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RubricButton.dark(
            style,
            width: NavbarWidget.navbarHeight,
            height: NavbarWidget.navbarHeight,
            onTap: () {
              editorState.widget.onLogoPressed();
            },
            padding: EdgeInsets.all(5),
            child: Image.network(style.logoUrl),
          ),
          RubricTextField(
            width: NavbarWidget.navbarHeight * 4,
            initialValue: editorState.canvas.value.settings.name,
            onChanged: (value) {
              editorState.canvas.updateSettings(
                editorState.canvas.value.settings.copyWith(name: value),
              );
            },
          ),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                if (editorState.previewing case PreviewModes mode) ...[
                  RubricIconButton(
                    isDark: true,
                    isActive: mode == PreviewModes.mobile,
                    iconData: Icons.phone_android,
                    size: NavbarWidget.navbarHeight,
                    disabled: true,
                    onTap: () {
                      editorState.setPreview(PreviewModes.mobile);
                    },
                  ),
                  RubricIconButton(
                    isDark: true,
                    isActive: mode == PreviewModes.desktop,
                    iconData: Icons.desktop_mac_rounded,
                    size: NavbarWidget.navbarHeight,
                    disabled: true,
                    onTap: () {
                      editorState.setPreview(PreviewModes.desktop);
                    },
                  ),
                ],
              ],
            ),
          ),

          RubricIconButton(
            isDark: true,
            iconData: Icons.undo,
            size: NavbarWidget.navbarHeight,
            disabled: !editorState.edits.canUndo,
            onTap: () {
              editorState.undo();
            },
          ),

          RubricIconButton(
            isDark: true,
            iconData: Icons.redo,
            size: NavbarWidget.navbarHeight,
            disabled: !editorState.edits.canRedo,
            onTap: () {
              editorState.redo();
            },
          ),
          RubricIconButton(
            isDark: true,
            iconData:
                editorState.previewing == null
                    ? Icons.remove_red_eye_rounded
                    : Icons.edit,
            size: NavbarWidget.navbarHeight,
            onTap: () {
              if (editorState.previewing == null) {
                editorState.setPreview(PreviewModes.desktop);
              } else {
                editorState.setPreview(null);
              }
            },
          ),
          RubricButton.theme(
            style,
            width: NavbarWidget.navbarHeight * 2,
            height: NavbarWidget.navbarHeight,
            child: RubricText("Save", textType: TextType.thick),
            onTap: () {
              editorState.save();
            },
          ),
        ],
      ),
    );
  }
}
