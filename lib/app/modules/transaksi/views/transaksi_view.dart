import 'package:catatan_keuangan/app/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for TextInputFormatter
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../controllers/transaksi_controller.dart';

class TransaksiView extends GetView<TransaksiController> {
  const TransaksiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TransaksiController controller = Get.put(TransaksiController());

    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background for better contrast
      appBar: AppBar(
        title: Text(
          "Tambah Transaksi",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.lightBlue,
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
              labelText: 'Nama Transaksi',
              onChanged: (value) => controller.namaTransaksi(value),
            ),
            SizedBox(height: 20),
            _buildCurrencyTextField(
              labelText: 'Jumlah',
              onChanged: (value) {
                if (value.isNotEmpty) {
                  controller.jumlah(int.parse(value.replaceAll('.', '')));
                }
              },
            ),
            SizedBox(height: 20),
            _buildTextField(
              labelText: 'Keterangan',
              onChanged: (value) => controller.keterangan(value),
            ),
            SizedBox(height: 40),
            Center(
              child: SizedBox(
                width: double
                    .infinity, // Membuat tombol selebar mungkin mengikuti padding kiri dan kanan
                child: ElevatedButton(
                  onPressed: () {
                    controller.submitTransaksiAdd();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightBlue,
                    foregroundColor: AppColors.white2,
                    padding: EdgeInsets.symmetric(
                        vertical: 16), // Hanya padding vertikal
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                    shadowColor: AppColors.blue1,
                  ),
                  child: Text(
                    'Kirim',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyTextField({
    required String labelText,
    required Function(String) onChanged,
  }) {
    return Obx(() {
      final TextEditingController textController = TextEditingController();
      final NumberFormat currencyFormatter =
          NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0);

      // Listen for changes in jumlah and update the text field
      textController.text = currencyFormatter
          .format(Get.find<TransaksiController>().jumlah.value);
      textController.selection =
          TextSelection.collapsed(offset: textController.text.length);

      return TextField(
        controller: textController,
        onChanged: onChanged,
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
    });
  }

  Widget _buildTextField({
    required String labelText,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      onChanged: onChanged,
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
}
