import 'package:flutter/material.dart';
import 'package:workmanagerexample/features/water/domain/entities/water_cup.dart';

class CupSelectionGrid extends StatelessWidget {
  final List<WaterCup> cups;
  final WaterCup? selectedCup;
  final Function(WaterCup) onCupSelected;

  const CupSelectionGrid({
    super.key,
    required this.cups,
    required this.selectedCup,
    required this.onCupSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: cups.length,
      itemBuilder: (context, index) {
        final cup = cups[index];
        final isSelected = selectedCup == cup;
        return GestureDetector(
          onTap: () => onCupSelected(cup),
          child: Card(
            color: isSelected ? Colors.blue : Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.local_drink,
                  size: 40,
                  color: isSelected ? Colors.white : Colors.blue,
                ),
                Text(
                  '${cup.amount}L',
                  style: TextStyle(
                    fontSize: 18,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  cup.label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}