import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmanagerexample/core/components/custom_text_field.dart';
import 'package:workmanagerexample/core/extensions/int_extension.dart';
import 'package:workmanagerexample/features/profile/domain/entities/user_profile.dart';
import 'package:workmanagerexample/features/profile/presentation/providers/user_profile_provider.dart';

class AgeTextField extends StatelessWidget {
  const AgeTextField({super.key, required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      initialValue: profile.age.toStringFormat,
      labelText: "Age",
      keyboardType: TextInputType.number,
      onChanged: (value) {
        Provider.of<UserProfileProvider>(
          context,
          listen: false,
        ).onAgeChanged(value);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your age';
        }
        if (int.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }
}
