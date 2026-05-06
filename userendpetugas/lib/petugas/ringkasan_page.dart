import 'package:flutter/material.dart';
import 'timbang_sampah.dart';
import 'dashboard_petugas.dart';

class RingkasanPage extends StatelessWidget {
  final List<Map<String, dynamic>> keranjang;
  final Map<String, String> user;

  const RingkasanPage({
    super.key,
    required this.keranjang,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = keranjang.isEmpty
        ? [
            {"nama": "Botol Plastik", "kategori": "Anorganik", "kg": 2},
            {"nama": "Gelas Plastik", "kategori": "Anorganik", "kg": 1},
            {"nama": "Plastik HDPE", "kategori": "Anorganik", "kg": 3},
            {"nama": "PVC", "kategori": "Anorganik", "kg": 1},
            {"nama": "Kardus", "kategori": "Kertas", "kg": 4},
            {"nama": "Kertas HVS", "kategori": "Kertas", "kg": 2},
            {"nama": "Kaleng", "kategori": "Logam", "kg": 1},
          ]
        : keranjang;

    final Map<String, int> harga = {
      "Botol Plastik": 4000,
      "Gelas Plastik": 3000,
      "Plastik HDPE": 3500,
      "PVC": 2000,
      "Kardus": 1500,
      "Kertas HVS": 1200,
      "Kaleng": 5000,
    };

    int totalKg = 0;
    int totalHarga = 0;

    for (var item in data) {
      int kg = item["kg"];
      int h = harga[item["nama"]] ?? 0;

      totalKg += kg;
      totalHarga += kg * h;
    }

    return Scaffold(
      backgroundColor: const Color(0xffF7F1F1),

      appBar: AppBar(
        title: const Text("Ringkasan Transaksi"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.grey,
                ),
                title: Text(user["nama"]!),
                subtitle: Text(user["alamat"]!),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final item = data[index];
                  int h = harga[item["nama"]] ?? 0;

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(
                        item["nama"],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("${item["kategori"]} • Rp $h/Kg"),
                      trailing: Text(
                        "${item["kg"]} Kg\nRp ${item["kg"] * h}",
                        textAlign: TextAlign.right,
                        style: const TextStyle(color: Colors.green),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total Kg : $totalKg Kg"),
                  const SizedBox(height: 4),
                  Text(
                    "Total Harga : Rp $totalHarga",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [

                // ➕ TAMBAH SAMPAH
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TimbangSampahPage(user: user),
                        ),
                      );
                    },
                    child: const Text("Tambah Sampah"),
                  ),
                ),

                const SizedBox(width: 12),

                // ✅ KONFIRMASI
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Transaksi berhasil +Rp $totalHarga"),
                        ),
                      );

  Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (_) => DashboardPetugas(
      nama: user["nama"] ?? "",
    ),
  ),
  (route) => false,
);
                    },
                    child: const Text("Konfirmasi"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}