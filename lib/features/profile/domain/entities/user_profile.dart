class UserProfile {
  final int? age;
  final double? weight;
  final String gender;

  const UserProfile({
    required this.age,
    required this.weight,
    required this.gender,
  });

  // Calculate recommended water intake based on age, weight and gender
  double get calculateWaterIntake {
    if (weight == null || age == null) {
      return 0.0;
    }
    // Base calculation using weight (30ml per kg)
    double baseIntake = weight! * 0.03;

    // Adjust for age
    if (age! > 65) {
      baseIntake *= 0.9; // Slightly lower for elderly
    } else if (age! < 30) {
      baseIntake *= 1.1; // Slightly higher for younger adults
    }

    // Adjust for gender
    if (gender.toLowerCase() == 'male') {
      baseIntake *= 1.1; // Men typically need more water
    }

    return double.parse(baseIntake.toStringAsFixed(1));
  }

  UserProfile copyWith({int? age, double? weight, String? gender}) {
    return UserProfile(
      age: age ?? this.age,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
    );
  }
}
