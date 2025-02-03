import 'package:flutter/material.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';
import 'package:rubric/src/shared/shared.dart';

class TopBarWidget extends StatelessWidget {
  static const double topBarHeight = 50;
  const TopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final style = RubricEditorStyle.of(context);

    return ColoredBox(
      color: style.light6,
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
    final style = RubricEditorStyle.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RubricIconButton(
          iconData: Icons.undo,
          size: TopBarWidget.topBarHeight,
          onTap: () {},
        ),
        RubricIconButton(
          iconData: Icons.redo,
          size: TopBarWidget.topBarHeight,
          onTap: () {},
        ),
        RubricIconButton(
          iconData: Icons.remove_red_eye_rounded,
          size: TopBarWidget.topBarHeight,
          onTap: () {},
        ),
        RubricIconButton(
          iconData: Icons.save,
          size: TopBarWidget.topBarHeight,
          onTap: () {},
        ),
      ],
    );
  }
}
