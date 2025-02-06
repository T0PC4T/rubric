import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';
import 'package:rubric/src/shared/shared.dart';

class NavbarWidget extends StatelessWidget {
  static const double navbarHeight = 40;
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final style = RubricEditorStyle.of(context);

    return ColoredBox(
      color: style.light8,
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
          iconData: Icons.undo,
          size: NavbarWidget.navbarHeight,
          onTap: () {
            editorState.undo();
          },
        ),
        RubricIconButton(
          iconData: Icons.redo,
          size: NavbarWidget.navbarHeight,
          onTap: () {},
        ),
        RubricIconButton(
          iconData: Icons.remove_red_eye_rounded,
          size: NavbarWidget.navbarHeight,
          onTap: () {},
        ),
        RubricIconButton(
          iconData: Icons.save,
          size: NavbarWidget.navbarHeight,
          onTap: () {},
        ),
      ],
    );
  }
}
