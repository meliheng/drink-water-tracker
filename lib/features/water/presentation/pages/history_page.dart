import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmanagerexample/core/components/custom_app_bar.dart';
import 'package:workmanagerexample/core/components/gradient_background_layout.dart';
import 'package:workmanagerexample/features/water/presentation/pages/components/history_list_item.dart';
import '../providers/water_history_provider.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Water Consumption History'),
      body: GradientBackgroundLayout(
        child: Consumer<WaterHistoryProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.error != null) {
              return Center(child: Text(provider.error!));
            }

            final history = provider.history;
            if (history.isEmpty) {
              return const Center(child: Text('No history available'));
            }

            return ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final record = history[index];
                return HistoryListItem(record: record);
              },
            );
          },
        ),
      ),
    );
  }
}
