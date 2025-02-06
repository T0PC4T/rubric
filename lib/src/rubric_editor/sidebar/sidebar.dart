// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:rubric/src/components/shared.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';
import 'package:rubric/src/rubric_editor/sidebar/pages/elements.dart';
import 'package:rubric/src/rubric_editor/sidebar/pages/general.dart';
import 'package:rubric/src/rubric_editor/sidebar/pages/layers.dart';

class RubricSideBar extends StatefulWidget {
  const RubricSideBar({super.key});

  static const double sideBarSize = 250;

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
    final style = RubricEditorStyle.of(context);
    return Container(
      decoration: BoxDecoration(color: style.light95),
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
