import 'package:flutter/material.dart';
import 'package:rubric/src/models/canvas.dart';
import 'package:rubric/src/models/editor_models.dart';
import 'package:rubric/src/rubric_editor/models/preview.dart';
import 'package:rubric/src/rubric_reader/padder.dart';

class RubricReader extends StatelessWidget {
  final CanvasModel canvasModel;
  final ViewModes? view;
  const RubricReader({
    super.key,
    required this.canvasModel,
    this.view,
  });

  @override
  Widget build(BuildContext context) {
    ViewModes? curView = view;
    if (curView == null) {
      Size size = MediaQuery.sizeOf(context);
      curView = size.width < ViewModes.mobile.width
          ? ViewModes.mobile
          : ViewModes.desktop;
    }
    return Container(
      width: double.infinity,
      color: canvasModel.settings.backgroundColor,
      child: SingleChildScrollView(
        child: PagePadderWidget(
          verticalEdgePadding: curView == ViewModes.mobile ? 0 : 25,
          horizontalEdgePadding: curView == ViewModes.mobile ? 0 : 25,
          pageWidth: curView.width,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: SizedBox(
              width: GridSizes.pageSize,
              height: canvasModel.readerPageHeight(),
              child: ColoredBox(
                color: canvasModel.settings.canvasColor,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    for (var element in canvasModel.elements)
                      Positioned(
                        left: element.x,
                        top: element.y,
                        width: element.width,
                        height: element.height,
                        child: element.type.readerBuilder(
                          key: ValueKey(element.id),
                          element: element,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
