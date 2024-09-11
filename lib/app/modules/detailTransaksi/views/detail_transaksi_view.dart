import 'package:catatan_keuangan/app/data/models/transaksi_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import '../controllers/detail_transaksi_controller.dart';

class DetailTransaksiView extends GetView<DetailTransaksiController> {
  DetailTransaksiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transaksi = controller.transaksi;
    String formattedDate = DateFormat('dd MMMM yyyy').format(transaksi.tanggal);

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Transaksi"),
        backgroundColor: Colors.blue[700],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[700]!, Colors.blue[50]!],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaksi.namaTransaksi.capitalizeFirst!,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                            ),
                          ),
                          SizedBox(height: 16),
                          _buildDetailRow(
                              Icons.calendar_today, "Tanggal", formattedDate),
                          _buildDetailRow(Icons.description, "Keterangan",
                              transaksi.keterangan.capitalizeFirst!),
                          _buildDetailRow(Icons.category, "Jenis",
                              transaksi.jenis?.capitalizeFirst ?? 'N/A'),
                          _buildDetailRow(
                            Icons.attach_money,
                            "Jumlah",
                            "Rp ${NumberFormat('#,##0', 'id_ID').format(transaksi.jumlah)}",
                            isAmount: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await _printPdf(transaksi);
                      } catch (e) {
                        Get.snackbar('Error', 'Failed to generate PDF: $e',
                            snackPosition: SnackPosition.BOTTOM);
                      }
                    },
                    child: Text("Print to PDF"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value,
      {bool isAmount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue[700], size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isAmount ? FontWeight.bold : FontWeight.normal,
                    color: isAmount ? Colors.green[700] : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _printPdf(Transaksi transaksi) async {
    final pdf = pw.Document();

    // Create a PDF page
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Detail Transaksi",
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text(
                  "Nama Transaksi: ${transaksi.namaTransaksi.capitalizeFirst}"),
              pw.Text(
                  "Tanggal: ${DateFormat('dd MMMM yyyy').format(transaksi.tanggal)}"),
              pw.Text("Keterangan: ${transaksi.keterangan.capitalizeFirst}"),
              pw.Text("Jenis: ${transaksi.jenis?.capitalizeFirst ?? 'N/A'}"),
              pw.Text(
                  "Jumlah: Rp ${NumberFormat('#,##0', 'id_ID').format(transaksi.jumlah)}"),
            ],
          );
        },
      ),
    );

    // Trigger the print
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
