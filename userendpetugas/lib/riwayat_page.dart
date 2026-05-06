import 'package:flutter/material.dart';
import 'data/user_data.dart';
import 'dashboard.dart';

class RiwayatPage extends StatelessWidget {
  final int total;
  final List<Map<String, dynamic>> data;

  const RiwayatPage({super.key, required this.total, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Konfirmasi Transaksi"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Detail Sampah",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // 🔥 LIST DATA
            Expanded(
              child: ListView(
                children: data.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text("${item['nama']} - ${item['kg']} Kg"),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 10),

            // 🔥 TOTAL
            Text(
              "Total: Rp $total",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // 🔥 TOMBOL SIMPAN
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // 🔥 SIMPAN KE GLOBAL
                  riwayatGlobal.add({
                    "tanggal": DateTime.now(),
                    "items": List.from(data),
                    "total": total,
                  });

                  // 🔥 NOTIFIKASI
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Transaksi berhasil disimpan"),
                    ),
                  );

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DashboardPage(username: "User", userId: 1),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(14),
                ),
                child: const Text("Simpan"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
