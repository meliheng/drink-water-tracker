import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_reminder/features/profile/domain/entities/user_profile.dart';
import 'package:water_reminder/features/profile/presentation/providers/user_profile_provider.dart';

class GenderDropdown extends StatelessWidget {
  const GenderDropdown({super.key, required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: profile.gender,
      decoration: const InputDecoration(
        labelText: 'Gender',
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(value: 'male', child: Text('Male')),
        DropdownMenuItem(value: 'female', child: Text('Female')),
      ],
      onChanged: (value) {
        Provider.of<UserProfileProvider>(
          context,
          listen: false,
        ).onWeightChanged(value);
      },
    );
  }
}
