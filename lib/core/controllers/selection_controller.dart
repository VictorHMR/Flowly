import 'package:flutter/material.dart';

class SelectionController<T> extends ChangeNotifier {
  final List<T> selectedItems = [];

  bool get isSelectionMode => selectedItems.isNotEmpty;

  bool isSelected(T item) {
    return selectedItems.contains(item);
  }

  void select(T item) {
    if (!selectedItems.contains(item)) {
      selectedItems.add(item);
      notifyListeners();
    }
  }

  void toggle(T item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
    notifyListeners();
  }

  void clear() {
    selectedItems.clear();

    notifyListeners();
  }
}
