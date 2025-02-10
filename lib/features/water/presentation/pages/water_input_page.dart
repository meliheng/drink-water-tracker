import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_reminder/core/components/custom_app_bar.dart';
import 'package:water_reminder/core/components/gradient_background_layout.dart';
import 'package:water_reminder/core/constants/water_constants.dart';

import '../providers/water_consumption_provider.dart';
import '../providers/water_input_provider.dart';
import 'components/cup_selection_grid.dart';
import 'components/water_amount_adjuster.dart';

class WaterInputPage extends StatelessWidget {
  const WaterInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WaterInputProvider(),
      child: Consumer2<WaterInputProvider, WaterConsumptionProvider>(
        builder: (context, inputProvider, consumptionProvider, child) {
          return Scaffold(
            appBar: CustomAppBar(title: "Add Water"),
            body: GradientBackgroundLayout(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Select Cup Size',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: CupSelectionGrid(
                        cups: WaterConstants.cups,
                        selectedCup: inputProvider.selectedCup,
                        onCupSelected: inputProvider.selectCup,
                      ),
                    ),
                    const SizedBox(height: 20),
                    WaterAmountAdjuster(
                      amount: inputProvider.selectedAmount,
                      onAmountChanged: inputProvider.adjustAmount,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed:
                          inputProvider.selectedAmount > 0
                              ? () {
                                consumptionProvider.updateConsumption(
                                  inputProvider.selectedAmount,
                                );
                                Navigator.pop(context);
                              }
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Add Water'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
