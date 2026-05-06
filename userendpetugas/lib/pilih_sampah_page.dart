import 'package:flutter/material.dart';
import 'package:user/mencari_petugas_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PilihSampahPage extends StatefulWidget {
  final String username;
  final String alamat;
  final String catatan;
  final double? userLat;
  final double? userLng;

  const PilihSampahPage({
    super.key,
    required this.username,
    required this.alamat,
    required this.catatan,
    this.userLat,
    this.userLng,
  });

  @override
  State<PilihSampahPage> createState() => _PilihSampahPageState();
}

class _PilihSampahPageState extends State<PilihSampahPage> {
  late TextEditingController catatanController;
  bool isOrganik = false;
  bool isAnorganik = false;
  bool isLainnya = false;

  Future<void> _createOrder() async {
    // Asumsi user_id = 1 untuk demo (user@test.com)
    const userId = 1;
    final jenisSampah = [];
    if (isOrganik) jenisSampah.add('organik');
    if (isAnorganik) jenisSampah.add('anorganik');
    if (isLainnya) jenisSampah.add('lainnya');

    final response = await http.post(
      Uri.parse('http://10.53.84.142:3000/orders'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'address': widget.alamat,
        'user_lat': widget.userLat,
        'user_lng': widget.userLng,
        'jenis_sampah': jenisSampah.join(', '),
        'catatan': catatanController.text,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        // Lanjut ke mencari petugas
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MencariPetugasPage(
              username: widget.username,
              orderId: data['order_id'],
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Gagal membuat order')));
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error koneksi')));
    }
  }

  @override
  void initState() {
    super.initState();

    catatanController = TextEditingController(text: widget.catatan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(20),
          ),

          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.person_outline, size: 16, color: Colors.green),
              const SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halo ${widget.username}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const Text(
                    'daur ulang sampahmu yuk!',
                    style: TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone_in_talk, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Alamat Penjemputan
            const Text(
              '📍 Alamat Penjemputan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(widget.alamat, style: const TextStyle(fontSize: 12)),
            ),

            const SizedBox(height: 30),
            const Center(
              child: Text(
                'Pilih Jenis Sampahmu',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),

            // Item Pilihan
            _buildCategoryItem(
              'Sampah Organik',
              'assets/organik.png',
              isOrganik,
              (val) {
                setState(() => isOrganik = val!);
              },
            ),
            _buildCategoryItem(
              'Sampah Anorganik',
              'assets/anorganik.png',
              isAnorganik,
              (val) {
                setState(() => isAnorganik = val!);
              },
            ),
            _buildCategoryItem(
              'Sampah Lainnya',
              'assets/lainnya.png',
              isLainnya,
              (val) {
                setState(() => isLainnya = val!);
              },
            ),

            const SizedBox(height: 20),
            const Text(
              'Catatan Untuk Sampah Lainnya',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: catatanController,

              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.green),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'cancel',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (!isOrganik && !isAnorganik && !isLainnya) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Pilih minimal satu jenis sampah'),
                          ),
                        );
                        return;
                      }
                      _createOrder();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'berikutnya',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    catatanController.dispose();
    super.dispose();
  }

  Widget _buildCategoryItem(
    String title,
    String imagePath,
    bool value,
    Function(bool?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.green,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFD1E4FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.recycling,
                    color: Colors.green,
                  ), // Ganti dengan Image.asset jika ada
                  const SizedBox(width: 15),
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
