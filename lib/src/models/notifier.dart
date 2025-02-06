import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:rubric/src/models/canvas.dart';
import 'package:rubric/src/models/editor_models.dart';
import 'package:rubric/src/models/elements.dart';

class EditorNotifier extends ValueNotifier<CanvasEditingModel> {
  EditorNotifier(super.value);

  clear() {
    value = value.copyWith(focused: null, selected: null);
  }

  selectElement(ElementModel? element) {
    value = value.copyWith(selected: element, focused: null);
  }

  focusElement(ElementModel element) {
    value = value.copyWith(selected: null, focused: element);
  }

  saveStep(CanvasModel step) {
    value = value.copyWith(
      selected: value.selected,
      focused: value.focused,
      steps: [step, ...value.steps.sublist(0, math.min(value.steps.length, 3))],
    );
  }

  bool isFocused(ElementModel element) {
    return value.focused == element;
  }

  bool isSelected(ElementModel element) {
    return value.selected == element;
  }

  bool get canUndo => value.steps.length > 1;
  CanvasModel get lastStep => value.steps[1];
}

class CanvasNotifier extends ValueNotifier<CanvasModel> {
  CanvasNotifier(super.value);

  // these actions do not actually change the state of canvas

  addElement(element) {
    value.elements = [...value.elements, element];
    commit();
  }

  @override
  notifyListeners() {
    print("CanvasNotifier.notifying");
    super.notifyListeners();
  }

  CanvasModel clone() {
    return value.copyWith();
  }

  commit() {
    print("COMMITTING");
    notifyListeners();
  }

  commitIfChange(CanvasModel canvas) {
    if (value != canvas) {
      commit();
    }
  }

  // ? Element are editable, they edit until a fixed point then the entire object is copied
  scaleElement(ElementModel element, Offset offset) {
    element.width = offset.dx;
    element.height = offset.dy;
  }

  moveElement(ElementModel element, Offset offset) {
    element.x = offset.dx;
    element.y = offset.dy;
  }

  updateElement(ElementModel element, Map<String, dynamic> properties) {
    element.properties = properties;
    commit();
  }

  reorderElements(int oldIndex, int newIndex) {
    // ? I switched this around because the list is reverse beware.
    if (oldIndex > newIndex) {
      newIndex += 1;
    }
    final ElementModel item = value.elements.removeAt(oldIndex);
    value.elements.insert(newIndex, item);
    commit();
  }

  changeProperties(ElementModel element, Map<String, dynamic> newPropeties) {
    element.properties = newPropeties;
  }

  deleteElement(ElementModel element) {
    value.elements.remove(element);
    commit();
  }

  double pageHeight() {
    return value.elements.fold<double>(GridSizes.pageSize, (
      previousValue,
      element,
    ) {
      final newHeight = element.y + element.height;
      if (newHeight > previousValue) {
        return newHeight;
      }
      return previousValue;
    });
  }
}
