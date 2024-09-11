import 'package:catatan_keuangan/app/controllers/auth_controller.dart';
import 'package:catatan_keuangan/app/data/repositories/auth/auth_repository.dart';
import 'package:catatan_keuangan/app/data/repositories/dompet/dompet_repository.dart';
import 'package:catatan_keuangan/app/data/repositories/profile/profile_repository.dart';
import 'package:catatan_keuangan/app/data/repositories/transaksi/transaksi_repository.dart';
import 'package:catatan_keuangan/app/data/repositories_impl/auth/auth_repository_impl.dart';
import 'package:catatan_keuangan/app/data/repositories_impl/dompet/dompet_repository_impl.dart';
import 'package:catatan_keuangan/app/data/repositories_impl/profile/profile_repository_impl.dart';
import 'package:catatan_keuangan/app/data/repositories_impl/transaksi/transaksi_repository_impl.dart';
import 'package:catatan_keuangan/app/modules/dompet/controllers/dompet_controller.dart';
import 'package:catatan_keuangan/app/modules/profile/controllers/profile_controller.dart';
import 'package:catatan_keuangan/app/modules/transaksi/controllers/transaksi_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'dio_utils.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() async {
    Get.put<Dio>(
      DioUtils.initDio(
        dotenv.env['BASE_URL'] ?? const String.fromEnvironment('BASE_URL'),
      ),
      permanent: true,
    );

    Get.put<FlutterSecureStorage>(
      const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock,
        ),
      ),
    );

    Get.put<AuthRepository>(
      AuthRepositoryImpl(
        client: Get.find<Dio>(),
        storage: Get.find<FlutterSecureStorage>(),
      ),
    );

    Get.put<DompetRepository>(
      DompetRepositoryImpl(
        client: Get.find<Dio>(),
        storage: Get.find<FlutterSecureStorage>(),
      ),
    );
    Get.put<TransaksiRepository>(
      TransaksiRepositoryImpl(
        client: Get.find<Dio>(),
        storage: Get.find<FlutterSecureStorage>(),
      ),
    );
    Get.put<ProfileRepository>(
      ProfileRepositoryImpl(
        client: Get.find<Dio>(),
        storage: Get.find<FlutterSecureStorage>(),
      ),
    );

    // Inisialisasi controller global (injection wajib diletakkan diakhir)
    Get.put(AuthController(), permanent: true);
    Get.put(DompetController(), permanent: true);
    Get.put(TransaksiController(), permanent: true);
    Get.put(ProfileController(), permanent: true);
  }
}
