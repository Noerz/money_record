import 'package:catatan_keuangan/app/core/theme/style.dart';
import 'package:catatan_keuangan/app/core/utils/prompt_utils.dart';
import 'package:catatan_keuangan/app/globals_widget/action_button.dart';
import 'package:catatan_keuangan/app/globals_widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedHeader(), // Add an animated header or logo
                const SizedBox(height: 24),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Selamat Datang',
                          textAlign: TextAlign.center,
                          style: h3.copyWith(
                            color: CustomColors.wireframe800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Masuk atau buat akun ',
                          textAlign: TextAlign.center,
                          style: subtle.copyWith(
                            color: CustomColors.wireframe700,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Form(
                          key: controller.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextfield(
                                controller: controller.emailController,
                                focusNode: controller.emailFocusNode,
                                labelText: 'Email',
                                hintText: 'Email',
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return '*wajib diisi';
                                  } else if (!value.isEmail) {
                                    return '*format email tidak valid';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              Obx(() {
                                return CustomTextfield(
                                  controller: controller.passwordController,
                                  focusNode: controller.passwordFocusNode,
                                  labelText: 'Password',
                                  hintText: 'Password',
                                  obscureText:
                                      !controller.isPasswordVisible.value,
                                  suffixIcon: GestureDetector(
                                    onTap: () =>
                                        controller.isPasswordVisible.toggle(),
                                    child: Icon(
                                      controller.isPasswordVisible.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: CustomColors.wireframe300,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return '*wajib diisi';
                                    }
                                    return null;
                                  },
                                );
                              }),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed('/registrasi');
                                  },
                                  child: Text(
                                    'Buat Akun',
                                    style: subtle.copyWith(
                                      color: CustomColors.wireframe400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ActionButton(
                            text: 'Login',
                            onPressed: () async {
                              if (controller.formKey.currentState
                                      ?.validate() ??
                                  true) {
                                PromptUtils.showLoading();

                                final result = await controller.loginWithEmail(
                                  email: controller.emailController.text,
                                  password:
                                      controller.passwordController.text,
                                );

                                PromptUtils.hideLoading();

                                if (result['success']) {
                                  Get.offAllNamed('/home');
                                } else {
                                  PromptUtils.showErrorDialog(
                                    'Login gagal',
                                    result['message'],
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Animated header for visual appeal
class AnimatedHeader extends StatefulWidget {
  @override
  _AnimatedHeaderState createState() => _AnimatedHeaderState();
}

class _AnimatedHeaderState extends State<AnimatedHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Column(
        children: [
          Image.asset(
            'assets/images/logo-smk.png', // Add your logo here
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 8),
          Text(
            'Welcome to MyApp',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
