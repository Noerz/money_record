import 'package:catatan_keuangan/app/core/const/keys.dart';
import 'package:catatan_keuangan/app/data/models/dompet_model.dart';
import 'package:catatan_keuangan/app/data/repositories/dompet/dompet_repository.dart';
import 'package:catatan_keuangan/app/modules/transaksi/controllers/transaksi_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class DompetController extends GetxController {
  final _dompetRepository = Get.find<DompetRepository>();
  final _secureStorage = Get.find<FlutterSecureStorage>();
  
  var dompet = <Dompet>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var totalSaldo = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDompet();
  }

  Future<void> fetchDompet() async {
  try {
    isLoading(true);
    var fetchedDompet = await _dompetRepository.getDompet();

    dompet.assignAll(fetchedDompet); // Assign fetched data to observable
    errorMessage(''); // Clear previous error messages
    calculateTotalSaldo(); // Calculate total saldo
    // Save each idDompet to secure storage
    for (var dompetItem in fetchedDompet) {
      await saveIdDompet(dompetItem.idDompet);
    }
  } catch (e) {
    errorMessage.value = e.toString(); // Set error message
  } finally {
    isLoading(false);
  }
}

  Future<void> updateDompet(
      int idDompet, String nama, double target, double saldo) async {
    try {
      isLoading(true);
      var result = await _dompetRepository.updateDompet(
          nama: nama, target: target, saldo: saldo);

      if (result['success']) {
        fetchDompet(); // Refresh list after update
      } else {
        errorMessage.value = result['message'];
      }
    } catch (e) {
      errorMessage.value = 'Error updating dompet: $e';
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteDompet(int idDompet) async {
  try {
    isLoading(true);
    var result = await _dompetRepository.deleteDompet(idDompet: idDompet);

    if (result['success']) {
      await fetchDompet(); // Refresh list after deletion
      calculateTotalSaldo(); // Ensure total saldo is updated
      clearDompetData();
      Get.find<TransaksiController>().clearTransactions();
    } else {
      errorMessage.value = result['message'];
    }
  } catch (e) {
    errorMessage.value = 'Error deleting dompet: $e';
  } finally {
    isLoading(false);
  }
}


  // Method to save idDompet in secure storage
  Future<void> saveIdDompet(int idDompet) async {
    try {
      await _secureStorage.write(
          key: '${Keys.idDompet}_$idDompet', value: idDompet.toString());
      print('idDompet $idDompet saved successfully');
    } catch (e) {
      print('Failed to save idDompet: ${e.toString()}');
      errorMessage.value = 'Failed to save idDompet';
    }
  }

  void calculateTotalSaldo() {
    totalSaldo.value = dompet.fold(
        0.0, (sum, item) => sum + item.saldo); // Calculate total saldo
  }

  Future<void> createDompet({
  required String nama,
  required double target,
  required double saldo,
}) async {
  try {
    isLoading(true);
    var result = await _dompetRepository.createDompet(
      nama: nama,
      target: target,
      saldo: saldo,
    );

    if (result['success']) {
      // Fetch dompet list only after successfully creating
      await fetchDompet(); // Ensure you call fetchDompet correctly here
    } else {
      errorMessage.value = result['message'];
    }
  } catch (e) {
    errorMessage.value = 'Error creating dompet: $e';
  } finally {
    isLoading(false);
  }
}


  // Method to clear all state data
  void clearDompetData() {
    dompet.clear();
    totalSaldo.value = 0.0;
    print('Dompet list cleared');
    errorMessage.value = '';
  }
}
