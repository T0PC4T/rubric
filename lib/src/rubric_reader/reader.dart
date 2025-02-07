import 'package:flutter/material.dart';
import 'package:rubric/src/models/canvas.dart';
import 'package:rubric/src/models/editor_models.dart';
import 'package:rubric/src/rubric_reader/padder.dart';

class RubricReader extends StatelessWidget {
  final CanvasModel canvasModel;
  const RubricReader({super.key, required this.canvasModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PagePadderWidget(
        backgroundColor: Colors.grey,
        child: Container(
          color: canvasModel.settings.backgroundColor,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: SizedBox(
              width: GridSizes.pageSize,
              height: canvasModel.readerPageHeight(),
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
    );
  }
}
