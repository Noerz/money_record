import 'package:catatan_keuangan/app/data/models/dompet_model.dart';
import 'package:catatan_keuangan/app/globals_widget/dialog/delete_dialog.dart';
import 'package:catatan_keuangan/app/modules/dompet/views/add_dompet_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dompet_controller.dart';

class DompetView extends GetView<DompetController> {
  const DompetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Daftar Dompet'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.warning_amber_rounded, size: 100, color: Colors.orange),
                SizedBox(height: 20),
                Text(
                  controller.errorMessage.value,
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }

        if (controller.dompet.isEmpty) {
          return Center(child: Text('No wallets available.'));
        }

        return RefreshIndicator(
          onRefresh: () async {
            await controller.fetchDompet(); // Ensure refreshing works properly
          },
          child: ListView.builder(
            itemCount: controller.dompet.length,
            itemBuilder: (context, index) {
              final dompet = controller.dompet[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Icon(Icons.account_balance_wallet, color: Colors.white),
                    ),
                    title: Text(
                      dompet.nama,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Text(
                          'Target: Rp ${dompet.target.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Saldo: Rp ${dompet.saldo.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    onTap: () => _showDeleteConfirmation(context, dompet), // Mengoper context ke metode
                  ),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: Obx(() {
        // Check if there are no wallets (dompet) to decide on showing the FAB
        if (!controller.isLoading.value && controller.dompet.isEmpty) {
          return FloatingActionButton(
            onPressed: () {
              Get.to(() => AddDompetView());
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blueAccent,
          );
        } else {
          return Container(); // Return an empty container if dompets exist or still loading
        }
      }),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Dompet dompet) async {
  bool shouldDelete = await deleteDialog(
    context,
    title: "Warning",
    description: "Are you sure you want to delete '${dompet.nama}'?",
    cancelButtonText: "No",
    confirmButtonText: "Yes",
  );

  if (shouldDelete) {
    // Lakukan tindakan penghapusan
    await controller.deleteDompet(dompet.idDompet);
    controller.fetchDompet(); // Refresh dompet list setelah penghapusan
  }
}

}
