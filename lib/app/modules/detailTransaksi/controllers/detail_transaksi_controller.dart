import 'package:get/get.dart';
import 'package:catatan_keuangan/app/data/models/transaksi_model.dart';

class DetailTransaksiController extends GetxController {
  late Transaksi transaksi;

  @override
  void onInit() {
    super.onInit();
    // Get the transaction data passed from HomeView
    transaksi = Get.arguments as Transaksi;
  }
}
