import 'package:catatan_keuangan/app/core/const/keys.dart';
import 'package:catatan_keuangan/app/data/models/transaksi_model.dart';
import 'package:catatan_keuangan/app/data/repositories/transaksi/transaksi_repository.dart';
import 'package:catatan_keuangan/app/modules/dompet/controllers/dompet_controller.dart';
import 'package:catatan_keuangan/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class TransaksiController extends GetxController {
  final TransaksiRepository _transaksiRepository =
      Get.find<TransaksiRepository>();
  final FlutterSecureStorage _secureStorage = Get.find<FlutterSecureStorage>();
  final DompetController _dompetController = Get.find<DompetController>();

  var isLoading = true.obs;
  var transaksiList = <Transaksi>[].obs;
  var errorMessage = ''.obs;

  var namaTransaksi = ''.obs;
  var tanggal = DateTime.now().obs;
  var jumlah = 0.obs;
  var keterangan = ''.obs;

  // Pagination variables
  int _currentPage = 1;
  final int _perPage = 10; // Default number of items per page
  bool _hasMoreData = true;

  @override
  void onInit() {
    super.onInit();
    _initFetch();
  }

  void _initFetch() async {
    final idDompetString = await _secureStorage.read(key: Keys.idDompet);
    if (idDompetString != null) {
      final idDompet = int.tryParse(idDompetString);
      if (idDompet != null) {
        fetchTransaksi(idDompet: idDompet);
      } else {
        errorMessage("Invalid idDompet");
        isLoading(false);
      }
    } else {
      isLoading(false);
    }
  }

  void fetchTransaksi({int? idDompet, bool isRefreshing = false}) async {
    if (!isRefreshing && !_hasMoreData) return;

    try {
      isLoading(true);
      if (isRefreshing) {
        _currentPage = 1;
        transaksiList.clear();
        _hasMoreData = true;
      }

      var newTransactions = await _transaksiRepository.getTransaksi(
        idDompet: idDompet ?? 0,
        page: _currentPage,
        limit: _perPage,
      );

      if (newTransactions.isEmpty) {
        _hasMoreData = false;
      } else {
        transaksiList.addAll(newTransactions);
        _currentPage++;
      }
    } catch (e) {
      errorMessage("Error fetching transactions: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

  Future<void> submitTransaksiAdd() async {
    await _submitTransaksi(_transaksiRepository.createTransaksiAdd);
  }

  Future<void> submitTransaksiReduce() async {
    await _submitTransaksi(_transaksiRepository.createTransaksiReduce);
  }

// Add this method to reset the page counter and data
  void resetPagination() {
    _currentPage = 1;
    _hasMoreData = true;
    transaksiList.clear();
  }

  Future<void> _submitTransaksi(
      Future<void> Function(Transaksi) createTransaksi) async {
    // Validate form fields
    if (namaTransaksi.value.isEmpty ||
        jumlah.value <= 0 ||
        keterangan.value.isEmpty) {
      // Handle validation errors...
      return;
    }

    try {
      isLoading(true);

      final idDompet = _dompetController.dompet.isNotEmpty
          ? _dompetController.dompet[0].idDompet
          : null;

      if (idDompet == null) {
        _showCreateWalletDialog();
        return;
      }

      var transaksi = Transaksi(
        dompetId: idDompet,
        namaTransaksi: namaTransaksi.value,
        tanggal: tanggal.value,
        jumlah: jumlah.value,
        keterangan: keterangan.value,
        idKategori: 1,
      );

      await createTransaksi(transaksi);

      // Reset pagination before refreshing the home data
      resetPagination();

      // Navigate back and trigger a refresh on HomeController
      Get.dialog(
        AlertDialog(
          title: Text('Transaksi Berhasil'),
          content: Text('Transaksi Anda telah berhasil diproses.'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                Get.offAllNamed('/home');
                Future.delayed(Duration(milliseconds: 500), () {
                  Get.find<HomeController>().fetchData();
                });
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      errorMessage("Error submitting transaction: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

  void _showCreateWalletDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Peringatan'),
        content: Text('Anda harus membuat dompet terlebih dahulu.'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.toNamed('/dompet');
            },
            child: Text('Buat Dompet'),
          ),
        ],
      ),
    );
  }

  void clearTransactions() {
    transaksiList.clear();
    errorMessage('');
    _currentPage = 1;
    _hasMoreData = true;
    print('Transaksi list cleared');
  }
}
