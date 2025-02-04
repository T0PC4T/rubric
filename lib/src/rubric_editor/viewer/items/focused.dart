import 'package:flutter/material.dart';

class CancelSelectionWidget extends LeafRenderObjectWidget {
  final bool cancels;
  const CancelSelectionWidget({super.key, required this.cancels});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCancelSelectionWidget(cancels: cancels);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderCancelSelectionWidget renderObject,
  ) {
    renderObject.cancels = cancels;
    renderObject.markNeedsPaint();
  }
}

class RenderCancelSelectionWidget extends RenderBox {
  static const int amount = 100;
  bool cancels;
  RenderCancelSelectionWidget({required this.cancels});

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  bool hitTestSelf(Offset position) {
    return true;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    Paint paint = Paint();
    if (cancels) {
      paint =
          Paint()
            ..color = Color.fromARGB(amount, 0, 0, 0)
            ..blendMode = BlendMode.srcOver;
    } else {
      paint =
          Paint()
            ..color = Color.fromARGB(100, 255, 255, 255)
            ..blendMode = BlendMode.plus;
    }

    context.canvas.drawRect(offset & size, paint);
  }
}
