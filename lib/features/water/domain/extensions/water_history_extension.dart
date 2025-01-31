import '../entities/water_consumption_history.dart';

extension WaterHistoryExtension on List<WaterConsumptionHistory> {
  List<WaterConsumptionHistory> combineByDate() {
    final Map<String, WaterConsumptionHistory> combinedMap = {};

    for (var record in this) {
      final dateKey =
          '${record.date.year}-${record.date.month}-${record.date.day}';

      if (combinedMap.containsKey(dateKey)) {
        final existing = combinedMap[dateKey]!;
        combinedMap[dateKey] = WaterConsumptionHistory(
          consumed: existing.consumed + record.consumed,
          target: record.target, // Keep the latest target
          date: record.date,
        );
      } else {
        combinedMap[dateKey] = record;
      }
    }

    return combinedMap.values.toList()
      ..sort((a, b) => b.date.compareTo(a.date)); // Sort by date descending
  }
}
