import 'package:flutter/material.dart';

class WaterAmountAdjuster extends StatelessWidget {
  final double amount;
  final Function(double) onAmountChanged;

  const WaterAmountAdjuster({
    super.key,
    required this.amount,
    required this.onAmountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => onAmountChanged(-0.1),
          icon: const Icon(Icons.remove_circle_outline),
          color: Colors.blue,
          iconSize: 32,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            '${amount.toStringAsFixed(1)}L',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          onPressed: () => onAmountChanged(0.1),
          icon: const Icon(Icons.add_circle_outline),
          color: Colors.blue,
          iconSize: 32,
        ),
      ],
    );
  }
}