import 'package:flutter/material.dart';
import 'ringkasan_page.dart';

class TimbangSampahPage extends StatelessWidget {
  final Map<String, String> user;

  const TimbangSampahPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F1F1),

      appBar: AppBar(
        title: const Text("Timbang Sampah"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // ================= USER =================
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

            const SizedBox(height: 20),

            // ================= KATEGORI =================
            kategoriItem(context, "Organik"),
            const SizedBox(height: 12),
            kategoriItem(context, "Anorganik"),
            const SizedBox(height: 12),
            kategoriItem(context, "Lainnya"),

            const Spacer(),

            // ================= BUTTON =================
            Row(
              children: [

                // ❌ BATAL
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Batal"),
                  ),
                ),

                const SizedBox(width: 12),

                // ✅ SELANJUTNYA → RINGKASAN
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RingkasanPage(
                            keranjang: [], // dummy dulu
                            user: user,
                          ),
                        ),
                      );
                    },
                    child: const Text("Selanjutnya"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================= ITEM KATEGORI =================
  Widget kategoriItem(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$title: Data belum diperbarui"),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 5),
          ],
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}