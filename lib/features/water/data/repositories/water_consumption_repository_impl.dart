import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_reminder/features/water/domain/entities/water_consumption_history.dart';

import '../../domain/entities/water_consumption.dart';
import '../../domain/repositories/water_consumption_repository.dart';

class WaterConsumptionRepositoryImpl implements WaterConsumptionRepository {
  final SharedPreferences _prefs;
  static const String _consumedKey = 'water_consumed';
  static const String _targetKey = 'water_target';
  static const double _defaultTarget = 5.0;

  WaterConsumptionRepositoryImpl(this._prefs);

  @override
  Future<WaterConsumption> getCurrentConsumption() async {
    final consumed = _prefs.getDouble(_consumedKey) ?? 0;
    final target = _prefs.getDouble(_targetKey) ?? _defaultTarget;
    return WaterConsumption(consumed: consumed, target: target);
  }

  @override
  Future<void> updateConsumption(double amount) async {
    final currentAmount = _prefs.getDouble(_consumedKey) ?? 0;
    await _prefs.setDouble(_consumedKey, currentAmount + amount);
  }

  @override
  Future<void> updateTarget(double target) async {
    await _prefs.setDouble(_targetKey, target);
  }

  @override
  Future<List<WaterConsumptionHistory>> getHistory() {
    throw UnimplementedError();
  }
}
