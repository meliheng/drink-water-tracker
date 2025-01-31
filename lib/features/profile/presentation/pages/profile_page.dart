import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmanagerexample/core/components/custom_app_bar.dart';
import 'package:workmanagerexample/core/components/gradient_background_layout.dart';
import 'package:workmanagerexample/features/profile/presentation/pages/components/age_text_field.dart';
import 'package:workmanagerexample/features/profile/presentation/pages/components/gender_dropdown.dart';
import 'package:workmanagerexample/features/profile/presentation/pages/components/intake_water_card.dart';
import 'package:workmanagerexample/features/profile/presentation/pages/components/profile_save_button.dart';
import 'package:workmanagerexample/features/profile/presentation/pages/components/weight_text_field.dart';
import '../providers/user_profile_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Profile"),
      body: GradientBackgroundLayout(
        child: Consumer<UserProfileProvider>(
          builder: (context, provider, child) {
            final profile = provider.profile;
            if (profile == null) return const CircularProgressIndicator();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          children: [
                            AgeTextField(profile: profile),
                            const SizedBox(height: 16),
                            WeightTextField(profile: profile),
                            const SizedBox(height: 16),
                            GenderDropdown(profile: profile),
                            const SizedBox(height: 32),
                            IntakeWaterCard(
                              value: profile.calculateWaterIntake,
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SafeArea(child: ProfileSaveButton(formKey: _formKey)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
