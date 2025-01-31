import 'package:flutter/foundation.dart';
import 'package:workmanagerexample/features/water/domain/entities/water_cup.dart';

class WaterInputProvider extends ChangeNotifier {
  double _selectedAmount = 0.0;
  WaterCup? _selectedCup;

  double get selectedAmount => _selectedAmount;
  WaterCup? get selectedCup => _selectedCup;

  void selectCup(WaterCup cup) {
    _selectedCup = cup;
    _selectedAmount = cup.amount;
    notifyListeners();
  }

  void adjustAmount(double delta) {
    _selectedAmount = (_selectedAmount + delta).clamp(0.0, 2.0);
    _selectedCup = null; // Clear cup selection when manually adjusting amount
    notifyListeners();
  }

  void clearSelection() {
    _selectedCup = null;
    _selectedAmount = 0.0;
    notifyListeners();
  }
}