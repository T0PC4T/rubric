// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:rubric/src/models/canvas.dart';
import 'package:rubric/src/models/elements.dart';

/*
These models are dedicated to the editor state. This state does not affect the actual lesson being built but only the current users editing view.
 */
enum GridSizes {
  none("Free", GridSizes.pageSize / 1000),
  small("Small", GridSizes.pageSize / 100),
  medium("Medium", 10),
  large("Large", GridSizes.pageSize / 25);

  static const double pageSize = 1000;

  final double pixelsPerLock;
  double get pixelsPerLine => 50;
  final String pretty;

  const GridSizes(this.pretty, this.pixelsPerLock);

  // from name
  static GridSizes fromName(String name) {
    return switch (name) {
      'none' => GridSizes.none,
      'small' => GridSizes.small,
      'medium' => GridSizes.medium,
      'large' => GridSizes.large,
      _ => throw Exception('Unknown grid size: name'),
    };
  }
}

class CanvasEditingModel {
  final ElementModel? selected;
  final ElementModel? focused;
  final List<CanvasModel> steps;
  final int undoIndex;
  final GridSizes gridSize;
  final bool showGrid;
  CanvasEditingModel({
    this.selected,
    this.focused,
    required this.steps,
    this.undoIndex = 0,
    this.gridSize = GridSizes.medium,
    this.showGrid = false,
  });

  CanvasEditingModel copyWith({
    required ElementModel? selected,
    required ElementModel? focused,
    List<CanvasModel>? steps,
    int? undoIndex,
    GridSizes? gridSize,
    bool? showGrid,
  }) {
    return CanvasEditingModel(
      selected: selected,
      focused: focused,
      steps: steps ?? this.steps,
      undoIndex: undoIndex ?? this.undoIndex,
      gridSize: gridSize ?? this.gridSize,
      showGrid: showGrid ?? this.showGrid,
    );
  }

  @override
  String toString() {
    return 'CanvasEditingModel(selected: $selected, focused: $focused, steps: $steps, undoIndex: $undoIndex, gridSize: $gridSize, showGrid: $showGrid)';
  }

  @override
  bool operator ==(covariant CanvasEditingModel other) {
    if (identical(this, other)) return true;

    return other.selected == selected &&
        other.focused == focused &&
        listEquals(other.steps, steps) &&
        other.undoIndex == undoIndex &&
        other.gridSize == gridSize &&
        other.showGrid == showGrid;
  }

  @override
  int get hashCode {
    return selected.hashCode ^
        focused.hashCode ^
        steps.hashCode ^
        undoIndex.hashCode ^
        gridSize.hashCode ^
        showGrid.hashCode;
  }
}
