import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rubric/src/models/elements.dart';

part 'editor.freezed.dart';
part 'editor.g.dart';

/*
These models are dedicated to the editor state. This state does not affect the actual lesson being built but only the current users editing view.
 */
enum GridSizes {
  free(GridSizes.pageSize / 100),
  small(GridSizes.pageSize / 20),
  medium(GridSizes.pageSize / 15),
  large(GridSizes.pageSize / 10),
  extraLarge(GridSizes.pageSize / 5);

  static const double pageSize = 1000;

  final double pixelsPerLine;

  const GridSizes(this.pixelsPerLine);
}

@freezed
class CanvasEditingModel with _$CanvasEditingModel {
  const factory CanvasEditingModel({
    // required Color backgroundColor,
    ElementModel? selected,
    @Default(GridSizes.medium) GridSizes gridSize,
    @Default(true) bool showGrid,
  }) = _CanvasEditingModel;

  factory CanvasEditingModel.fromJson(Map<String, dynamic> json) =>
      _$CanvasEditingModelFromJson(json);
}
