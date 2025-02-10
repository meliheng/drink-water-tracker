import 'package:flutter/material.dart';
import 'package:water_reminder/features/water/domain/extensions/water_history_extension.dart';
import 'package:water_reminder/features/water/domain/repositories/water_consumption_repository.dart';

import '../../domain/entities/water_consumption_history.dart';

class WaterHistoryProvider extends ChangeNotifier {
  final WaterConsumptionRepository _repository;

  List<WaterConsumptionHistory> _history = [];
  bool _isLoading = false;
  String? _error;

  WaterHistoryProvider(this._repository);

  List<WaterConsumptionHistory> get history => _history;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadHistory() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 1));
      _history = await _repository.getHistory();
      _history = _history.combineByDate();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshHistory() async {
    await loadHistory();
  }

  void clearHistory() {
    _history = [];
    notifyListeners();
  }
}
