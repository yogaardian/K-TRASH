import 'package:flutter/material.dart';
import 'timbang_sampah.dart';

const primaryColor = Color(0xFF4CAF50);

class PencarianCostamerPage extends StatefulWidget {
  const PencarianCostamerPage({super.key});

  @override
  State<PencarianCostamerPage> createState() =>
      _PencarianCostamerPageState();
}

class _PencarianCostamerPageState
    extends State<PencarianCostamerPage> {

  final TextEditingController kodeController = TextEditingController();

  Map<String, String>? dataUser;

  final Map<String, Map<String, String>> dummyDatabase = {
    "0025": {
      "nama": "Bodida",
      "alamat": "RT 10, Desa Sigungguan",
      "saldo": "Rp 75.000",
    },
    "0027": {
      "nama": "Slamet",
      "alamat": "Desa Kedungrejo",
      "saldo": "Rp 50.000",
    },
  };

  /// 🔍 AUTO SEARCH + VALIDASI
  void cariUser() {
    String kode = kodeController.text.trim();

    if (kode.isEmpty) {
      setState(() => dataUser = null);
      return;
    }

    if (dummyDatabase.containsKey(kode)) {
      setState(() {
        dataUser = dummyDatabase[kode];
      });
    } else {
      setState(() {
        dataUser = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F1F1),
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// TITLE
              const Center(
                child: Text(
                  "Pencarian Customer",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// INPUT
              const Text("Masukkan Kode Customer"),
              const SizedBox(height: 8),

              TextField(
                controller: kodeController,
                onChanged: (value) => cariUser(), // 🔥 AUTO SEARCH
                decoration: InputDecoration(
                  hintText: "Contoh: 0025",
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// HASIL
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: dataUser != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const Text(
                            "Hasil Pencarian",
                            style: TextStyle(color: Colors.grey),
                          ),

                          const SizedBox(height: 10),

                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            child: Row(
                              children: [

                                /// AVATAR
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: primaryColor,
                                  child: Text(
                                    dataUser!["nama"]![0],
                                    style: const TextStyle(
                                        color: Colors.white),
                                  ),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dataUser!["nama"]!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(dataUser!["alamat"]!),
                                      Text(
                                        dataUser!["saldo"]!,
                                        style: const TextStyle(
                                            color: Colors.green),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(
                        height: 200,
                        child: Center(
                          child: Text(
                            "Masukkan kode untuk mencari customer",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
              ),

              const SizedBox(height: 20),

              /// BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: dataUser == null
                        ? Colors.grey.shade400
                        : primaryColor,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: dataUser == null
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  TimbangSampahPage(user: dataUser!),
                            ),
                          );
                        },
                  child: const Text(
                    "Lanjut Timbang",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}