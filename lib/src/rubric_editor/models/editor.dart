import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rubric/src/elements/models/elements.dart';

part 'editor.freezed.dart';
part 'editor.g.dart';

/*
These models are dedicated to the editor state. This state does not affect the actual lesson being built but only the current users editing view.
 */
enum GridSizes {
  none("Free", GridSizes.pageSize / 100),
  small("Small", GridSizes.pageSize / 50),
  medium("Medium", GridSizes.pageSize / 20),
  large("Large", GridSizes.pageSize / 15),
  extraLarge("Extra Large", GridSizes.pageSize / 10);

  static const double pageSize = 1500;

  final double pixelsPerLine;
  final String pretty;

  const GridSizes(this.pretty, this.pixelsPerLine);
}

@freezed
class CanvasEditingModel with _$CanvasEditingModel {
  const factory CanvasEditingModel({
    // required Color backgroundColor,
    ElementModel? selected,
    ElementModel? focused,
    @Default(GridSizes.medium) GridSizes gridSize,
    @Default(true) bool showGrid,
  }) = _CanvasEditingModel;

  factory CanvasEditingModel.fromJson(Map<String, dynamic> json) =>
      _$CanvasEditingModelFromJson(json);
}
