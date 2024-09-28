import 'package:catatan_keuangan/app/data/models/user_model.dart';
import 'dart:io';

abstract class ProfileRepository {
  Future<User?> getProfile();

  Future<Map<String, dynamic>> updateProfile({
    required String fullName,
    required String adress,
    required String noHp,
    required String gender,
  });

  // // Mendapatkan URL gambar profil
  // Future<String> getProfilePicture();

  // Mengupdate gambar profil
  Future<void> updateProfilePicture(File imageFile);
}
