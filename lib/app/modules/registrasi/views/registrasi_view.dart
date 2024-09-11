import 'dart:developer';

import 'package:catatan_keuangan/app/core/theme/style.dart';
import 'package:catatan_keuangan/app/core/utils/prompt_utils.dart';
import 'package:catatan_keuangan/app/globals_widget/action_button.dart';
import 'package:catatan_keuangan/app/globals_widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/registrasi_controller.dart';

class RegistrasiView extends GetView<RegistrasiController> {
  const RegistrasiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimatedLogo(),
                const SizedBox(height: 24),
                AnimatedText(),
                const SizedBox(height: 32),
                Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextfield(
                        controller: controller.nameController,
                        focusNode: controller.nameFocusNode,
                        labelText: 'Nama',
                        hintText: 'Nama',
                      ),
                      const SizedBox(height: 16),
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
                          obscureText: !controller.isPasswordVisible.value,
                          suffixIcon: GestureDetector(
                            onTap: () => controller.isPasswordVisible.toggle(),
                            child: Icon(
                              controller.isPasswordVisible.value ? Icons.visibility_off : Icons.visibility,
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
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Role',
                          hintText: 'Pilih Role',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        value: controller.roleController.text.isEmpty ? null : controller.roleController.text,
                        items: [
                          DropdownMenuItem(
                            value: 'guru',
                            child: Text('Guru'),
                          ),
                          DropdownMenuItem(
                            value: 'murid',
                            child: Text('Murid'),
                          ),
                        ],
                        onChanged: (value) {
                          controller.roleController.text = value!;
                          log(controller.roleController.text);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '*wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      Hero(
                        tag: 'register-button',
                        child: ActionButton(
                          text: 'Registrasi',
                          onPressed: () async {
                            if (controller.formKey.currentState?.validate() ?? false) {
                              PromptUtils.showLoading();
                              final result = await controller.register(
                                fullName: controller.nameController.text,
                                email: controller.emailController.text,
                                password: controller.passwordController.text,
                                role: controller.roleController.text,
                              );
                              log("isi dari result registrasi : $result");
                              PromptUtils.hideLoading();
                              if (result['success']) {
                                _showSuccessDialog(context);
                              } else {
                                _showFailureDialog(context, result['message']);
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    Get.dialog(
      AnimatedDialog(
        icon: Icons.check_circle_outline,
        iconColor: Colors.green,
        title: 'Registrasi Berhasil',
        message: 'Akun Anda telah berhasil dibuat. Silakan login untuk melanjutkan.',
        onConfirm: () => Get.offAllNamed('/login'),
      ),
    );
  }

  void _showFailureDialog(BuildContext context, String message) {
    Get.dialog(
      AnimatedDialog(
        icon: Icons.error_outline,
        iconColor: Colors.red,
        title: 'Registrasi Gagal',
        message: message,
        onConfirm: () => Get.back(),
      ),
    );
  }
}

// Unified Animated Dialog
class AnimatedDialog extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final VoidCallback onConfirm;

  const AnimatedDialog({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.message,
    required this.onConfirm,
  }) : super(key: key);

  @override
  _AnimatedDialogState createState() => _AnimatedDialogState();
}

class _AnimatedDialogState extends State<AnimatedDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(widget.icon, size: 60, color: widget.iconColor),
                const SizedBox(height: 16),
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  widget.message,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: widget.onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.iconColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('OK'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Animation for the logo
class AnimatedLogo extends StatefulWidget {
  @override
  _AnimatedLogoState createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(
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
      child: Image.asset(
        'assets/images/logo-smk.png', // Replace with your logo asset
        width: 150,
        height: 150,
      ),
    );
  }
}

// Animation for the text
class AnimatedText extends StatefulWidget {
  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();

    _animation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
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
    return SlideTransition(
      position: _animation,
      child: Column(
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
            'Buat Akun Baru',
            textAlign: TextAlign.center,
            style: subtle.copyWith(
              color: CustomColors.wireframe700,
            ),
          ),
        ],
      ),
    );
  }
}
