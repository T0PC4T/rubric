import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/components/shared.dart';

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
            width: NavbarWidget.navbarHeight * 5,
            initialValue: editorState.canvas.value.settings.name,
            onChanged: (value) {
              editorState.canvas.updateSettings(
                editorState.canvas.value.settings.copyWith(name: value),
              );
            },
          ),
          Expanded(
            child: Center(
              child: RubricIconButton(
                isDark: true,
                iconData: Icons.desktop_mac_rounded,
                size: NavbarWidget.navbarHeight,
                disabled: true,
                onTap: () {},
              ),
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
            iconData: Icons.remove_red_eye_rounded,
            size: NavbarWidget.navbarHeight,
            onTap: () {
              editorState.togglePreview();
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
