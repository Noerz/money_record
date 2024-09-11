import 'package:catatan_keuangan/app/data/models/user_model.dart';

abstract class AuthRepository {
  Future<User> login({
    required String email,
    required String password,
  });

  Future<Map<String, dynamic>> register({
    required String fullName,
    required String email,
    required String password,
    required String role, // Tambahkan parameter role
  });
}

