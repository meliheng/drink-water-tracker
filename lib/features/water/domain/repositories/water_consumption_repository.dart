import 'package:water_reminder/features/water/domain/entities/water_consumption_history.dart';

import '../entities/water_consumption.dart';

abstract class WaterConsumptionRepository {
  Future<WaterConsumption> getCurrentConsumption();
  Future<void> updateConsumption(double amount);
  Future<void> updateTarget(double target);
  Future<List<WaterConsumptionHistory>> getHistory();
}
