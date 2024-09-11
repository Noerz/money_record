import 'package:catatan_keuangan/app/controllers/auth_controller.dart';
import 'package:get/get.dart';

class MoreController extends GetxController {
  final _authController = Get.find<AuthController>();
  //TODO: Implement MoreController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<Map<String, dynamic>> logout() async {
    return await _authController.logout();
  }
}
