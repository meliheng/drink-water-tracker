import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_reminder/core/components/custom_app_bar.dart';
import 'package:water_reminder/core/components/gradient_background_layout.dart';
import 'package:water_reminder/features/water/presentation/pages/components/profile_button.dart';

import '../providers/water_consumption_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        color: Colors.transparent,
        elevation: 0,
        actions: [ProfileButton()],
      ),
      body: GradientBackgroundLayout(
        child: Consumer<WaterConsumptionProvider>(
          builder: (context, provider, child) {
            final consumption = provider.waterConsumption;
            if (consumption == null) return const CircularProgressIndicator();
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Water Logo
                  const Icon(Icons.water_drop, size: 120, color: Colors.blue),
                  const SizedBox(height: 20),
                  // Water Consumption Text
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 24, color: Colors.black),
                      children: [
                        TextSpan(
                          text: consumption.consumed.toStringAsFixed(1),
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(text: ' / '),
                        TextSpan(
                          text: consumption.target.toStringAsFixed(1),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: ' L'),
                      ],
                    ),
                  ),
                  const Text(
                    'Daily Consumed Water',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
