import 'package:workmanagerexample/core/extensions/datetime_extension.dart';

class WaterConsumptionHistory {
  final double consumed;
  final double target;
  final DateTime date;

  const WaterConsumptionHistory({
    required this.consumed,
    required this.target,
    required this.date,
  });

  String get formattedDate {
    return date.isToday ? "TODAY" : date.formattedDate;
  }

  double get percentageAchieved {
    return (consumed / target * 100).clamp(0, 100);
  }
}
