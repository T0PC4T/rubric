import 'package:rubric/src/models/editor_models.dart';

enum PreviewModes {
  desktop(GridSizes.pageSize),
  mobile(250);

  final double width;
  const PreviewModes(this.width);
}
