import 'package:flutter/material.dart';

import '../../features/water/domain/entities/water_cup.dart';

class WaterConstants {
  static final List<WaterCup> cups = [
  WaterCup(icon: Icons.local_drink, amount: 0.2, label: 'Small Cup'),
  WaterCup(icon: Icons.local_cafe, amount: 0.3, label: 'Medium Cup'),
  WaterCup(icon: Icons.sports_bar, amount: 0.5, label: 'Large Cup'),
];
}