import 'package:flutter/foundation.dart';
import 'package:workmanagerexample/features/water/domain/repositories/water_consumption_repository.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/user_profile_repository.dart';

class UserProfileProvider extends ChangeNotifier {
  final UserProfileRepository _repository;
  final WaterConsumptionRepository _waterConsumptionRepository;
  UserProfile? _profile;

  UserProfileProvider(this._repository, this._waterConsumptionRepository);

  UserProfile? get profile => _profile;

  Future<void> loadProfile() async {
    _profile = await _repository.getUserProfile();
    notifyListeners();
  }

  void onAgeChanged(String? value) {
    if (value != null) {
      final age = int.tryParse(value);
      _profile = _profile?.copyWith(age: age);
      notifyListeners();
    }
  }

  void onWeightChanged(String? value) {
    if (value != null) {
      final weight = double.tryParse(value);
      _profile = _profile?.copyWith(weight: weight);
      notifyListeners();
    }
  }

  void onGenderSelected(String? value) {
    _profile = _profile?.copyWith(gender: value);
    notifyListeners();
  }

  Future<void> updateProfile() async {
    await _repository.saveUserProfile(_profile!);
    await _waterConsumptionRepository.updateTarget(
      _profile!.calculateWaterIntake,
    );
  }
}
