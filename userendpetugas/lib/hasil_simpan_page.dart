import 'package:flutter/material.dart';
import 'riwayat_page.dart';

class HasilSimpanPage extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const HasilSimpanPage({super.key, required this.data});

  final Map<String, int> hargaSampah = const {
    "PET (Botol air mineral)": 4000,
    "HDPE : (Botol sabun)": 3000,
    "PVC : (Pipa, kabel)": 2000,
    "LDPE : (Kantong kresek)": 3500,
    "PP : (Tutup botol, sedotan)": 2500,
    "PS : (Styrofoam, tempat makanan)": 1500,
    "Plastik campur : (Bungkus sachet)": 1000,
  };

  @override
  Widget build(BuildContext context) {
    int total = 0;

    for (var item in data) {
      int harga = hargaSampah[item['nama']] ?? 0;
      int kg = item['kg'] as int;
      total += harga * kg;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Tersimpan"),
        backgroundColor: Colors.green,
      ),
      body: data.isEmpty
          ? const Center(child: Text("Tidak ada data"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];

                      int harga = hargaSampah[item['nama']] ?? 0;
                      int kg = item['kg'] as int;
                      int subtotal = harga * kg;

                      return ListTile(
                        leading: const Icon(Icons.delete, color: Colors.green),
                        title: Text(
                          item['nama'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text("$kg Kg"),
                        trailing: Text(
                          "Rp $subtotal",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("${item['nama']} dipilih"),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                // TOTAL
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "Total: Rp $total",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // BUTTON
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text("Tambah Sampah"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // 🔥 HANYA PINDAH (BELUM SIMPAN)
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RiwayatPage(
                                  total: total,
                                  data: data,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text("Konfirmasi"),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
    );
  }
}