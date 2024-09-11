import 'package:catatan_keuangan/app/data/models/user_model.dart';

abstract class ProfileRepository {
  Future<User?> getProfile();
  Future<Map<String, dynamic>> updateProfile({
    required String fullName,
    required String adress,
    required String noHp,
    required String gender,
  });
  // Future<void> updateProfile(User user); // New method
}
