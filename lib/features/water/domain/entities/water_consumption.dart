class WaterConsumption {
  final double consumed;
  final double target;
  final DateTime? date;

  const WaterConsumption({
    required this.consumed,
    required this.target,
    this.date,
  });
}