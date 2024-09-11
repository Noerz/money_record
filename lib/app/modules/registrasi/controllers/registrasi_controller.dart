import 'package:catatan_keuangan/app/controllers/auth_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegistrasiController extends GetxController {
  final _authController = Get.find<AuthController>();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final roleController = TextEditingController();
  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final roleFocusNode = FocusNode();

  RxBool isPasswordVisible = false.obs;

  Future<Map<String, dynamic>> register({
    required String fullName,
    required String email,
    required String password,
    required String role,
  }) async {
    return await _authController.register(
      fullName: fullName,
      email: email,
      password: password,
      role: role,
    );
  }
}
