import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/user_profile_repository.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final SharedPreferences _prefs;
  static const String _ageKey = 'user_age';
  static const String _weightKey = 'user_weight';
  static const String _genderKey = 'user_gender';

  UserProfileRepositoryImpl(this._prefs);

  @override
  Future<UserProfile> getUserProfile() async {
    final age = _prefs.getInt(_ageKey);
    final weight = _prefs.getDouble(_weightKey);
    final gender = _prefs.getString(_genderKey) ?? 'male';

    return UserProfile(age: age, weight: weight, gender: gender);
  }

  @override
  Future<void> saveUserProfile(UserProfile profile) async {
    await _prefs.setInt(_ageKey, profile.age!);
    await _prefs.setDouble(_weightKey, profile.weight!);
    await _prefs.setString(_genderKey, profile.gender);
  }
}
