import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/components/shared.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';

class NavbarWidget extends StatelessWidget {
  static const double navbarHeight = 40;
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final style = RubricEditorStyle.of(context);

    return ColoredBox(
      color: style.dark,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Icon(Icons.person, size: 30),
            ),
          ),
          RubricText("Lesson Name", textType: TextType.title),
          Expanded(child: TopBarActions()),
        ],
      ),
    );
  }
}

class TopBarActions extends StatelessWidget {
  const TopBarActions({super.key});

  @override
  Widget build(BuildContext context) {
    final editorState = RubricEditorState.of(context);
    final style = RubricEditorStyle.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RubricIconButton(
          isDark: true,
          iconData: Icons.undo,
          size: NavbarWidget.navbarHeight,
          onTap: () {
            editorState.undo();
          },
        ),
        RubricIconButton(
          isDark: true,
          iconData: Icons.redo,
          size: NavbarWidget.navbarHeight,
          onTap: () {},
        ),
        RubricIconButton(
          isDark: true,
          iconData: Icons.remove_red_eye_rounded,
          size: NavbarWidget.navbarHeight,
          onTap: () {},
        ),
        RubricIconButton(
          isDark: true,
          iconData: Icons.save,
          size: NavbarWidget.navbarHeight,
          onTap: () {},
        ),
      ],
    );
  }
}
