import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

/// Parent data for use with [RenderStack].
class RuPositionParentData extends ContainerBoxParentData<RenderBox> {
  double? y;
  double? x;
  double? width;
  double? height;
  int? linesAcross;

  // RuPositionParentData.fromElement(ElementModel element);

  BoxConstraints positionedChildConstraints(Size stackSize) {
    if (width!.isInfinite) {
      return BoxConstraints.tightFor(
        width: stackSize.width,
        height: stackSize.height,
      );
    }
    return BoxConstraints.tightFor(width: width!, height: height!);
  }

  @override
  String toString() {
    final List<String> values = <String>[
      if (x != null) 'top=${debugFormatDouble(x)}',
      if (y != null) 'right=${debugFormatDouble(y)}',
      if (width != null) 'width=${debugFormatDouble(width)}',
      if (height != null) 'height=${debugFormatDouble(height)}',
    ];
    values.add(super.toString());
    return values.join('; ');
  }
}
