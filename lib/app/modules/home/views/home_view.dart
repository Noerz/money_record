import 'package:catatan_keuangan/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeView extends GetView<HomeController> {
  final ScrollController _scrollController = ScrollController();

  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.fetchData(); // Ensure refresh updates the data
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade200, Colors.blue.shade600],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Selamat Datang, ${controller.userName.value}', // Ensure userName is defined in the controller
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // Optionally, add a profile icon or other actions
                      Obx(
                        () => CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: controller.profile.value.isNotEmpty
                              ? NetworkImage(controller.profile.value)
                              : AssetImage('assets/images/logo-smk.png')
                                  as ImageProvider,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Saldo Anda',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Obx(() {
                    // Use Obx to observe changes in totalSaldo
                    return Text(
                      'Rp ${controller.totalSaldo.value.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildIconWithText(Icons.add_circle_outline,
                          'Tambah Saldo', Colors.green, () {
                        Get.toNamed("/transaksi");
                      }),
                      _buildIconWithText(Icons.remove_circle_outline,
                          'Ambil Saldo', Colors.red, () {
                        Get.toNamed("/transaksi-reduce");
                      }),
                      _buildIconWithText(
                          Icons.account_balance_wallet, 'Dompet', Colors.orange,
                          () {
                        Get.toNamed("/dompet");
                      }),
                      _buildIconWithText(Icons.apps, 'Lainnya', Colors.purple,
                          () {
                        Get.toNamed("/more");
                      }),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Transaksi',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: controller.transaksiList.isEmpty
                      ? _buildNoTransactionsView()
                      : ListView.builder(
                          key: ValueKey<int>(controller.transaksiList.length),
                          controller: _scrollController,
                          itemCount: controller.transaksiList.length,
                          itemBuilder: (context, index) {
                            final transaksi = controller.transaksiList[index];
                            return GestureDetector(
                              onTap: () => Get.toNamed('/detail-transaksi',
                                  arguments: transaksi),
                              child: _buildTransactionTile(
                                transaksi.namaTransaksi,
                                DateFormat('yyyy-MM-dd')
                                    .format(transaksi.tanggal),
                                transaksi.jumlah,
                                Icons.attach_money,
                              ),
                            );
                          },
                        ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoTransactionsView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            opacity: 1.0,
            duration: Duration(seconds: 2),
            child: Icon(
              Icons.inbox,
              color: Colors.grey,
              size: 80,
            ),
          ),
          SizedBox(height: 20),
          AnimatedOpacity(
            opacity: 1.0,
            duration: Duration(seconds: 2),
            child: Text(
              'No Transactions',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconWithText(
      IconData icon, String text, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: color, size: 40),
          SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionTile(
      String title, String date, int amount, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(12),
          leading: CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            child: Icon(icon, color: Colors.black54),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Text(
                date,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 5),
            ],
          ),
          trailing: Text(
            'Rp ${amount.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}',
            style: TextStyle(
              color: Colors.green,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
