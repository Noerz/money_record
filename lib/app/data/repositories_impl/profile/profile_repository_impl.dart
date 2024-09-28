import 'dart:developer';

import 'package:catatan_keuangan/app/core/const/endpoints.dart';
import 'package:catatan_keuangan/app/core/const/keys.dart';
import 'package:catatan_keuangan/app/data/models/user_model.dart';
import 'package:catatan_keuangan/app/data/repositories/profile/profile_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';

class ProfileRepositoryImpl extends ProfileRepository {
  final Dio client;
  final FlutterSecureStorage storage;

  ProfileRepositoryImpl({
    required this.client,
    required this.storage,
  });

  @override
  Future<User?> getProfile() async {
    try {
      final token = await storage.read(key: Keys.token);
      final response = await client.get(
        Endpoints.profile,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        var profileData = response.data['data'];
        if (profileData != null) {
          return User.fromJson(profileData);
        } else {
          return null;
        }
      } else {
        throw Exception(response.data['message'] ?? 'Profile tidak ditemukan');
      }
    } on DioError catch (dioError) {
      if (dioError.response != null) {
        throw dioError.response?.data['message'] ?? 'Unknown server error';
      } else {
        throw Exception('Network error: ${dioError.message}');
      }
    } catch (e) {
      throw 'Failed to load profile: $e';
    }
  }

  // Future<String> getProfilePicture() async {
  //   try {
  //     final token = await storage.read(key: Keys.token);
  //     final response = await client.get(
  //       Endpoints.profilePicture,
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer $token',
  //           'Accept': 'image/*',
  //         },
  //         responseType: ResponseType.bytes,
  //       ),
  //     );
  //     print("hasil dari profile picture : ${response}");

  //     if (response.statusCode == 200) {
  //       return "http://192.168.1.13:3000" + response.requestOptions.path;
  //     } else {
  //       throw Exception(response.data['message'] ?? 'Failed to get profile picture');
  //     }
  //   } catch (e) {
  //     throw 'Failed to get profile picture: $e';
  //   }
  // }

  Future<void> updateProfilePicture(File imageFile) async {
    
  try {
    final token = await storage.read(key: Keys.token);
    final fileName = imageFile.path.split('/').last;
    print("isi dari imageFile : ${imageFile.path}");
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
      ),
    });

    final response = await client.put(
      Endpoints.changeProfilePicture,
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data'
        },
      ),
    );

    if (response.statusCode == 200) {
      // Update the profile picture successfully
    } else {
      throw Exception(response.data['message'] ?? 'Failed to update profile picture');
    }
  } catch (e) {
    rethrow;
  }
}

  @override
  Future<Map<String, dynamic>> updateProfile({
    required String fullName,
    required String adress,
    required String noHp,
    required String gender,
  }) async {
    try {
      final token = await storage.read(key: Keys.token);
      final response = await client.put(
        Endpoints.profile,
        data: {
          'fullName': fullName,
          'adress': adress,
          'noHp': noHp,
          'gender': gender,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.data['message'] ?? 'Failed to update profile');
      }
    } on DioError catch (dioError) {
      if (dioError.response != null) {
        throw dioError.response?.data['message'] ?? 'Unknown server error';
      } else {
        throw Exception('Network error: ${dioError.message}');
      }
    } catch (e) {
      throw 'Failed to update profile: $e';
    }
  }
}
