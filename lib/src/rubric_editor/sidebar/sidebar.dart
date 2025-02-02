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
    final tile = editorState.edits.gridSize.pixelsPerLine.toDouble();
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 231, 231, 231),
      ),
      width: RubricSideBar.sideBarSize,
      height: double.infinity,
      child: Column(
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
          SingleChildScrollView(child: RubricSideBar.pages[pageIndex]),
        ],
      ),
    );
  }
}

// class RubricSidebarButton extends StatefulWidget {
//   final ElementTypes type;
//   final double width;

//   const RubricSidebarButton({
//     super.key,
//     required this.type,
//     required this.width,
//   });

//   @override
//   State<RubricSidebarButton> createState() => _RubricSidebarButtonState();
// }

// class _RubricSidebarButtonState extends State<RubricSidebarButton> {
//   bool hovered = false;

//   @override
//   Widget build(BuildContext context) {
//     final editorState = RubricEditorState.depend(context);
//     final style = RubricEditorStyle.of(context)!;
//     final tile = editorState.edits.gridSize.pixelsPerLine.toDouble();
//     return GestureDetector(
//       onTap: () {
//         final state = RubricEditorState.depend(context);
//         state.addElementAndFocus(
//           ElementModel(
//             id: UniqueKey().toString(),
//             type: widget.type,
//             x: tile,
//             y: tile * 4,
//             width: tile,
//             height: tile,
//             properties:
//                 BoxElementModel(
//                   color: const Color.fromARGB(255, 114, 227, 255),
//                 ).toJson(),
//           ),
//         );
//       },

//       child: MouseRegion(
//         onEnter: (event) {
//           setState(() {
//             hovered = true;
//           });
//         },

//         onExit: (event) {
//           setState(() {
//             hovered = false;
//           });
//         },

//         child: Container(
//           padding: EdgeInsets.all(15),
//           // box decoration with border radisu
//           color:
//               hovered
//                   ? Color.lerp(style.backgroundColor, style.primaryColor, 0.4)
//                   : style.backgroundColor,
//           width: widget.width,
//           height: widget.width,
//           child:
//         ),
//       ),
//     );
//   }
// }
