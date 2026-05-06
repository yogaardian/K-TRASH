import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ================= TANGGAL OTOMATIS =================
    String tanggal = DateFormat('dd MMM yyyy').format(DateTime.now());

    // ================= DATA SAMA SEPERTI RINGKASAN =================
    final List<Map<String, dynamic>> riwayat = [
      {
        "user": {"nama": "Bodida", "alamat": "RT 10, Desa Sigungguan"},
        "tanggal": tanggal,
        "total": 38500,
        "data": [
          {"nama": "Botol Plastik", "kategori": "Anorganik", "kg": 2},
          {"nama": "Gelas Plastik", "kategori": "Anorganik", "kg": 1},
          {"nama": "Plastik HDPE", "kategori": "Anorganik", "kg": 3},
          {"nama": "PVC", "kategori": "Anorganik", "kg": 1},
          {"nama": "Kardus", "kategori": "Kertas", "kg": 4},
          {"nama": "Kertas HVS", "kategori": "Kertas", "kg": 2},
          {"nama": "Kaleng", "kategori": "Logam", "kg": 1},
        ],
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF7F1F1),

      appBar: AppBar(
        title: const Text("Riwayat Transaksi"),
        backgroundColor: Colors.green,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: riwayat.length,
        itemBuilder: (context, index) {
          final item = riwayat[index];

          return GestureDetector(
            onTap: () {
              // ================= DETAIL =================
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Text(item["user"]["nama"]),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tanggal: ${item["tanggal"]}"),
                      const SizedBox(height: 10),

                      const Text(
                        "Jenis Sampah:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 5),

                      ...List.generate(item["data"].length, (i) {
                        final d = item["data"][i];
                        return Text(
                          "${d["nama"]} (${d["kategori"]}) : ${d["kg"]} Kg",
                        );
                      }),

                      const SizedBox(height: 10),

                      Text(
                        "Total: Rp ${item["total"]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Tutup"),
                    ),
                  ],
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["user"]["nama"],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      item["tanggal"],
                      style: const TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Total: Rp ${item["total"]}",
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
