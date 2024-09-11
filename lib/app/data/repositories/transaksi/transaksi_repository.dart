import 'package:catatan_keuangan/app/data/models/transaksi_model.dart';

abstract class TransaksiRepository {
  Future<List<Transaksi>> getTransaksi({
    int? idDompet,
    int page = 1,
    int limit = 10, // Adjusted default limit for pagination
  });
  Future<void> createTransaksiAdd(Transaksi transaksi);
  Future<void> createTransaksiReduce(Transaksi transaksi);
}
