import 'package:catatan_keuangan/app/data/models/transaksi_model.dart';
import 'package:catatan_keuangan/app/modules/dompet/controllers/dompet_controller.dart';
import 'package:catatan_keuangan/app/modules/profile/controllers/profile_controller.dart';
import 'package:catatan_keuangan/app/modules/transaksi/controllers/transaksi_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final DompetController _dompetController = Get.find<DompetController>();
  final ProfileController _profileController = Get.find<ProfileController>();
  final TransaksiController _transaksiController =
      Get.find<TransaksiController>();
// Reactive property to hold the user's name
  RxString get userName => _profileController.fullName;
  RxString get profile => _profileController.profilePictureUrl;
  @override
  void onInit() {
    super.onInit();
    fetchData(); // Ensure data is fetched when the controller is initialized
  }

  Future<void> fetchData({bool isRefreshing = false}) async {
    // Await the completion of fetchDompet before proceeding
    await _dompetController.fetchDompet();
    await _profileController.fetchProfile();

    // Ensure dompet is not empty and fetchTransaksi after dompet data is ready
    if (_dompetController.dompet.isNotEmpty) {
      final idDompet = _dompetController.dompet[0].idDompet;

      if (isRefreshing) {
        _transaksiController.resetPagination(); // Reset pagination on refresh
      }

      _transaksiController.fetchTransaksi(idDompet: idDompet);
    }
  }

  // Expose totalSaldo directly from DompetController
  RxDouble get totalSaldo => _dompetController.totalSaldo;

  // Expose transaksiList from TransaksiController
  RxList<Transaksi> get transaksiList => _transaksiController.transaksiList;
}
