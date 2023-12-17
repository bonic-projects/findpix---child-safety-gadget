import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ChildActivityViewModel extends BaseViewModel {
  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      _selectedDate = picked;
      notifyListeners();
    }
  }
}
