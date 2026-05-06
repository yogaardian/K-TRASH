import 'package:flutter/material.dart';

class AkunPage extends StatelessWidget {
  const AkunPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F1F1),

      body: SafeArea(
        child: Column(
          children: [

            // ================= HEADER =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 77, 175, 84),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.arrow_back, color: Colors.black),
                  SizedBox(width: 10),
                  Text(
                    "Profileku",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ================= PROFILE CARD =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xffFDF6F6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [

                    const CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.grey,
                    ),

                    const SizedBox(width: 16),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sarah",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text("sarah@gmail.com"),
                          Text("081234567890"),
                        ],
                      ),
                    ),

                    const Icon(Icons.edit),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ================= MENU =================
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [

                  const Text("Aktivitas BankTrash"),
                  const SizedBox(height: 10),

                  menuCard([
                    "Alamat Tersimpan",
                    "Aktivitas",
                  ]),

                  const SizedBox(height: 16),

                  const Text("Lainnya"),
                  const SizedBox(height: 10),

                  menuCard([
                    "Bantuan dan laporan",
                    "Ketentuan layanan",
                    "Hapus akun",
                    "Keluar",
                  ]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // ================= MENU CARD =================
  Widget menuCard(List<String> items) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffFDF6F6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: items.map((e) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(child: Text(e)),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}