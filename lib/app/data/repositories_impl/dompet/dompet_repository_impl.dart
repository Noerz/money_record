import 'package:catatan_keuangan/app/core/const/endpoints.dart';
import 'package:catatan_keuangan/app/core/const/keys.dart';
import 'package:catatan_keuangan/app/data/models/dompet_model.dart';
import 'package:catatan_keuangan/app/data/repositories/dompet/dompet_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DompetRepositoryImpl extends DompetRepository {
  final Dio client;
  final FlutterSecureStorage storage;

  DompetRepositoryImpl({
    required this.client,
    required this.storage,
  });

  @override
  Future<List<Dompet>> getDompet() async {
    try {
      final token = await storage.read(key: Keys.token);
      final response = await client.get(
        Endpoints.dompet,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        var dompetData = response.data['data'];

        if (dompetData is List) {
          return dompetData.map((e) => Dompet.fromJson(e)).toList();
        } else {
          return [];
        }
      } else {
        throw Exception(response.data['message'] ?? 'Dompet tidak ditemukan');
      }
    } on DioError catch (dioError) {
      if (dioError.response != null) {
        throw dioError.response?.data['message'] ?? 'Unknown server error';
      } else {
        throw Exception('Network error: ${dioError.message}');
      }
    } catch (e) {
      throw 'Failed to load dompet: $e';
    }
  }

  @override
  Future<Map<String, dynamic>> createDompet({
    required String nama,
    required double target,
    required double saldo,
  }) async {
    try {
      final token = await storage.read(key: Keys.token);
      final response = await client.post(
        Endpoints.addDompet,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'nama': nama,
          'target': target,
          'saldo': saldo,
        },
      );

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': response.data['message'],
          'data': response.data['data'], // Ensure data is correctly mapped
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Failed to create dompet',
        };
      }
    } on DioError catch (dioError) {
      if (dioError.response != null) {
        return {
          'success': false,
          'message': dioError.response?.data['message'] ?? 'Unknown server error',
        };
      } else {
        return {
          'success': false,
          'message': 'Network error: ${dioError.message}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Create dompet failed, please try again. $e',
      };
    }
  }

  @override
  Future<Map<String, dynamic>> updateDompet({
    required String nama,
    required double target,
    required double saldo,
  }) async {
    try {
      final token = await storage.read(key: Keys.token);
      final id = await storage.read(key: Keys.idDompet);
      final response = await client.put(
        Endpoints.addDompet,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'nama': nama,
          'target': target,
          'saldo': saldo,
        },
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': response.data['message'],
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'],
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Update dompet failed, please try again. $e',
      };
    }
  }

  @override
  Future<Map<String, dynamic>> deleteDompet({required int idDompet}) async {
    try {
      final token = await storage.read(key: Keys.token);
      final response = await client.delete(
        Endpoints.addDompet,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        queryParameters: {
          'idDompet': idDompet,
        },
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': response.data['message'],
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'],
        };
      }
    } on DioError catch (dioError) {
      if (dioError.response != null) {
        return {
          'success': false,
          'message': dioError.response?.data['message'] ?? 'Unknown server error',
        };
      } else {
        return {
          'success': false,
          'message': 'Network error: ${dioError.message}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Delete dompet failed, please try again. $e',
      };
    }
  }
}
