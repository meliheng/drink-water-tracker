import 'package:flutter/material.dart';

class WaterCup {
  final IconData icon;
  final double amount;
  final String label;

  const WaterCup({
    required this.icon,
    required this.amount,
    required this.label,
  });

  Map<String, dynamic> toMap() {
    return {
      'icon': icon,
      'amount': amount,
      'label': label,
    };
  }

  factory WaterCup.fromMap(Map<String, dynamic> map) {
    return WaterCup(
      icon: map['icon'] as IconData,
      amount: map['amount'] as double,
      label: map['label'] as String,
    );
  }
}