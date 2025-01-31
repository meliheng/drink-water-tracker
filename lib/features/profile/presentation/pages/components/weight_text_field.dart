import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmanagerexample/core/components/custom_text_field.dart' show CustomTextField;
import 'package:workmanagerexample/features/profile/domain/entities/user_profile.dart';
import 'package:workmanagerexample/features/profile/presentation/providers/user_profile_provider.dart';

class WeightTextField extends StatelessWidget {
  const WeightTextField({
    super.key,
    required this.profile,
  });

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      initialValue: profile.weight.toString(),
      labelText: "Weight (kg)",
       keyboardType: TextInputType.number,
      onChanged: (value) {
        Provider.of<UserProfileProvider>(
          context,
          listen: false,
        ).onWeightChanged(value);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your weight';
        }
        if (double.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }
}