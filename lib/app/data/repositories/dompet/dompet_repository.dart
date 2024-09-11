import 'package:catatan_keuangan/app/data/models/dompet_model.dart';

abstract class DompetRepository {
  Future<List<Dompet>> getDompet();

  Future<Map<String, dynamic>> createDompet({
    required String nama,
    required double target,
    required double saldo,
  });

  Future<Map<String, dynamic>> updateDompet({
    required String nama,
    required double target,
    required double saldo,
  });

  Future<Map<String, dynamic>> deleteDompet({
    required int idDompet,
  });
}
