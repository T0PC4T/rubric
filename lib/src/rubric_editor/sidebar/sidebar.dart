// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:rubric/src/components/shared.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';
import 'package:rubric/src/rubric_editor/sidebar/pages/elements.dart';
import 'package:rubric/src/rubric_editor/sidebar/pages/general.dart';
import 'package:rubric/src/rubric_editor/sidebar/pages/layers.dart';

class RubricSideBar extends StatefulWidget {
  const RubricSideBar({super.key});

  static const double sideBarSize = 260;

  static const pages = [
    ElementPageWidget(),
    GeneralSettingsPageWidget(),
    LayersPageWidget(),
  ];

  @override
  State<RubricSideBar> createState() => RubricSideBarState();
}

class RubricSideBarState extends State<RubricSideBar> {
  static const menusIcons = [
    Icons.shape_line_rounded,
    Icons.settings,
    Icons.layers,
  ];
  static const menus = ["Elements", "Settings", "Structure"];

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
              for (var i = 0; i < menus.length; i++)
                Expanded(
                  child: RubricButton(
                    hoverColor: style.light9,
                    backgroundColor:
                        i == pageIndex ? style.light9 : style.light,
                    height: 70,
                    onTap: () {
                      setState(() {
                        pageIndex = i;
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: RubricEditorStyle.paddingUnit,
                      children: [
                        Opacity(
                          opacity: i == pageIndex ? 1 : 0,
                          child: Container(
                            color: style.theme,
                            height: 5,
                            width: double.infinity,
                          ),
                        ),
                        Icon(menusIcons[i], size: 25),
                        RubricText(
                          menus[i],
                          textType: TextType.small,
                        ),
                      ],
                    ),
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
