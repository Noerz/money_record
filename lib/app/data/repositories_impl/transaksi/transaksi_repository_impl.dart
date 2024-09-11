import 'package:catatan_keuangan/app/core/const/endpoints.dart';
import 'package:catatan_keuangan/app/core/const/keys.dart';
import 'package:catatan_keuangan/app/data/models/transaksi_model.dart';
import 'package:catatan_keuangan/app/data/repositories/transaksi/transaksi_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TransaksiRepositoryImpl extends TransaksiRepository {
  final Dio client;
  final FlutterSecureStorage storage;

  TransaksiRepositoryImpl({required this.client, required this.storage});

  @override
  Future<List<Transaksi>> getTransaksi({
    int? idDompet,
    int page = 1,
    int limit = 10, // Default pagination limit
  }) async {
    try {
      final token = await storage.read(key: Keys.token);

      final response = await client.get(
        Endpoints.transaksi,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        queryParameters: {
          if (idDompet != null) 'idDompet': idDompet,
          'page': page,
          'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        var data = response.data['data'];

        if (data is List) {
          return data.map((e) => Transaksi.fromJson(e)).toList();
        } else {
          return [];
        }
      } else {
        throw response.data['message'] ?? 'Error ${response.statusCode}';
      }
    } catch (e) {
      throw 'Gagal mendapatkan transaksi: ${e.toString()}';
    }
  }

  @override
  Future<void> createTransaksiAdd(Transaksi transaksi) async {
    await _createTransaksi(transaksi, Endpoints.pemasukan);
  }

  @override
  Future<void> createTransaksiReduce(Transaksi transaksi) async {
    await _createTransaksi(transaksi, Endpoints.pengeluaran);
  }

  Future<void> _createTransaksi(Transaksi transaksi, String endpoint) async {
    try {
      final token = await storage.read(key: Keys.token);

      final response = await client.post(
        endpoint,
        data: transaksi.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode != 201) {
        throw response.data['message'] ?? 'Error ${response.statusCode}';
      }
    } catch (e) {
      throw 'Gagal memproses transaksi: ${e.toString()}';
    }
  }
}
