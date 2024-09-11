import 'package:catatan_keuangan/app/core/const/endpoints.dart';
import 'package:catatan_keuangan/app/data/models/user_model.dart';
import 'package:catatan_keuangan/app/data/repositories/auth/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepositoryImpl extends AuthRepository {
  final Dio client;
  final FlutterSecureStorage storage;

  AuthRepositoryImpl({
    required this.client,
    required this.storage,
  });

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.post(
        Endpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final userData =
            response.data['data']; // Ambil data di dalam objek data
        return User.fromJson(userData);
      } else {
        // Handle non-200 responses
        throw Exception(
            'Login failed with status code: ${response.statusCode}');
      }
    } on DioError catch (dioError) {
      // Handle Dio errors separately for more detailed network-related errors
      if (dioError.response != null) {
        // Server responded with an error status code
        throw dioError.response?.data['message'] ?? 'Unknown server error';
      } else {
        // No response from the server or other network errors
        throw Exception('Network error: ${dioError.message}');
      }
    } catch (e) {
      // Handle any other type of exceptions
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> register({
    required String fullName,
    required String email,
    required String password,
    required String role, // Tambahkan parameter role
  }) async {
    try {
      final response = await client.post(
        Endpoints.register,
        data: {
          'fullName': fullName,
          'email': email,
          'password': password,
          'role': role, // Tambahkan field role
        },
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': response.data['data'],
        };
      } else {
        return {
          'success': false,
          'message': response.data['data'],
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Register new account failed, please try again. $e',
      };
    }
  }
}
