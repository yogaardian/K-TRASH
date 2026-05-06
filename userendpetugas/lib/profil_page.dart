import 'package:flutter/material.dart';

// TAMBAHKAN CLASS INI: Ini adalah model data agar variabel 'user' bisa dikenali
class UserProfile {
  final String name;
  final String email;
  final String phoneNumber;
  final String? profileImage;

  UserProfile({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.profileImage,
  });
}

class ProfilePage extends StatelessWidget {
  // Sekarang UserProfile sudah didefinisikan dan tidak akan error lagi
  final UserProfile user; 

  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // Header Background Hijau
          Container(
            height: 200,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF81C784), Color(0xFFC8E6C9)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                // Tombol Back & Judul
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Text(
                        'Profileku',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Kartu Profil (Data otomatis terhubung)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey.shade300,
                          child: const Icon(Icons.person, size: 40, color: Colors.white),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name, // Muncul otomatis sesuai registrasi
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(user.email, style: const TextStyle(color: Colors.grey)),
                              Text(user.phoneNumber, style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                        const Icon(Icons.edit, color: Colors.black),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // List Menu
                _buildMenuSection('Aktivitas BankTrash', [
                  _buildMenuItem(Icons.location_on_outlined, 'Alamat Tersimpan'),
                  _buildMenuItem(Icons.history, 'Aktivitas'),
                ]),
                const SizedBox(height: 20),
                _buildMenuSection('Lainnya', [
                  _buildMenuItem(Icons.help_outline, 'Bantuan dan laporan'),
                  _buildMenuItem(Icons.description_outlined, 'Ketentuan layanan'),
                  _buildMenuItem(Icons.person_remove_outlined, 'Hapus akun'),
                  _buildMenuItem(Icons.logout, 'Keluar', isLogout: true),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(String title, List<Widget> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(children: items),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.black87),
      title: Text(label, style: TextStyle(color: isLogout ? Colors.red : Colors.black87)),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: () {},
    );
  }
}