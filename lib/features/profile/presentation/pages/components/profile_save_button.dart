import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_reminder/core/components/primary_button.dart';
import 'package:water_reminder/features/profile/presentation/providers/user_profile_provider.dart';
import 'package:water_reminder/features/water/presentation/providers/water_consumption_provider.dart';

class ProfileSaveButton extends StatelessWidget {
  const ProfileSaveButton({super.key, required GlobalKey<FormState> formKey})
    : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      title: "Save Profile",
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          final profileProvider = Provider.of<UserProfileProvider>(
            context,
            listen: false,
          );
          await profileProvider.updateProfile();

          // Reload water consumption data to reflect the new target
          if (context.mounted) {
            final waterProvider = Provider.of<WaterConsumptionProvider>(
              context,
              listen: false,
            );
            await waterProvider.loadConsumption();

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile saved successfully')),
            );
          }
        }
      },
    );
  }
}
