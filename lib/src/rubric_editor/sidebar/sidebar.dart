// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/rubric_editor/sidebar/pages/elements.dart';
import 'package:rubric/src/rubric_editor/sidebar/pages/general.dart';
import 'package:rubric/src/rubric_editor/sidebar/pages/layers.dart';
import 'package:rubric/src/shared/shared.dart';

class RubricSideBar extends StatefulWidget {
  const RubricSideBar({super.key});

  static const double sideBarSize = 200;

  static const pages = [
    ElementPageWidget(),
    GeneralSettingsPageWidget(),
    LayersPageWidget(),
  ];

  static const menus = ["Element", "Settings", "Layers"];

  @override
  State<RubricSideBar> createState() => RubricSideBarState();
}

class RubricSideBarState extends State<RubricSideBar> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    final editorState = RubricEditorState.depend(context);
    return Container(
      decoration: BoxDecoration(color: editorState.style.light6),
      width: RubricSideBar.sideBarSize,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              for (var menu in RubricSideBar.menus)
                Expanded(
                  child: RubricButton(
                    height: RubricSideBar.sideBarSize * 0.3,
                    onTap: () {
                      setState(() {
                        pageIndex = RubricSideBar.menus.indexOf(menu);
                      });
                    },
                    child: RubricText(menu),
                  ),
                ),
            ],
          ),
          Expanded(child: RubricSideBar.pages[pageIndex]),
        ],
      ),
    );
  }
}
