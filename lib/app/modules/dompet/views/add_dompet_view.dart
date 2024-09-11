import 'package:catatan_keuangan/app/globals_widget/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../controllers/dompet_controller.dart';

class AddDompetView extends GetView<DompetController> {
  const AddDompetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController targetController = TextEditingController();
    final TextEditingController saldoController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Tambah Dompet",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            _buildTextField(
              labelText: 'Nama Dompet',
              controller: nameController,
            ),
            SizedBox(height: 20),
            _buildCurrencyTextField(
              labelText: 'Target',
              controller: targetController,
            ),
            SizedBox(height: 20),
            _buildCurrencyTextField(
              labelText: 'Saldo Awal',
              controller: saldoController,
            ),
            SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Validate inputs
                  if (nameController.text.isEmpty ||
                      targetController.text.isEmpty ||
                      saldoController.text.isEmpty) {
                    Get.snackbar('Error', 'Semua field harus diisi');
                    return;
                  }

                  // Parse inputs and create dompet
                  final nama = nameController.text.trim();
                  final target = double.tryParse(
                          targetController.text.replaceAll('.', '')) ??
                      0.0;
                  final saldo = double.tryParse(
                          saldoController.text.replaceAll('.', '')) ??
                      0.0;

                  controller.createDompet(
                      nama: nama, target: target, saldo: saldo);

                  // Show success dialog with animation
                  Get.dialog(
                    SuccessDialog(
                      title: 'Dompet Berhasil Ditambahkan',
                      message: 'Dompet Anda telah berhasil ditambahkan.',
                      onConfirm: () {
                        Get.back(); // Close dialog
                        Get.offAllNamed("/home"); // Navigate to dompet view
                      },
                    ),
                    barrierDismissible: false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                  shadowColor: Colors.blueAccent,
                ),
                child: Text(
                  'Tambah Dompet',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(fontSize: 16),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.blueGrey,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildCurrencyTextField({
    required String labelText,
    required TextEditingController controller,
  }) {
    final NumberFormat currencyFormatter =
        NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0);

    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, // Allow digits only
      ],
      style: GoogleFonts.poppins(fontSize: 16),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.blueGrey,
        ),
        prefixText: 'Rp ',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
