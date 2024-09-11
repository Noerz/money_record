import 'package:get/get.dart';

import '../controllers/dompet_controller.dart';

class DompetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DompetController>(
      () => DompetController(),
    );
  }
}
