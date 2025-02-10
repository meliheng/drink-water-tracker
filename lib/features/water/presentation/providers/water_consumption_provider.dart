import 'package:flutter/foundation.dart';
import 'package:water_reminder/features/water/domain/entities/water_consumption.dart';
import 'package:water_reminder/features/water/domain/repositories/water_consumption_repository.dart';

class WaterConsumptionProvider extends ChangeNotifier {
  final WaterConsumptionRepository _repository;
  WaterConsumption? _waterConsumption;

  WaterConsumptionProvider(this._repository);

  WaterConsumption? get waterConsumption => _waterConsumption;

  Future<void> loadConsumption() async {
    _waterConsumption = await _repository.getCurrentConsumption();
    notifyListeners();
  }

  Future<void> updateConsumption(double amount) async {
    await _repository.updateConsumption(amount);
    await loadConsumption();
  }

  Future<void> updateTarget(double target) async {
    await _repository.updateTarget(target);
    await loadConsumption();
  }
}
