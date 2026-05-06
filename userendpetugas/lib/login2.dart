import 'package:flutter/material.dart';
import 'register.dart';
import 'dashboard.dart';
import 'data/user_data.dart';
import 'petugas/dashboard_petugas.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController usernameEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌿 BACKGROUND
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🌿 OVERLAY
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.85),
                  Colors.green.withOpacity(0.2),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // 🌿 CONTENT
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 80),

                // 🌿 LOGO
                Image.asset('assets/LogoK-Trash.png', height: 140),

                const SizedBox(height: 20),

                // 🌿 CARD
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Selamat Datang! 🌿",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                        ),

                        const SizedBox(height: 5),

                        const Text(
                          "Masuk untuk melanjutkan ke K-Trash",
                          style: TextStyle(color: Colors.black54),
                        ),

                        const SizedBox(height: 20),

                        // TOGGLE
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => RegisterPage(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    child: const Text(
                                      'Daftar',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF6DDC5C),
                                        Color(0xFF2E7D32),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Text(
                                    'Login',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        _buildField(
                          'Username / Email',
                          usernameEmailController,
                          icon: Icons.person_outline,
                        ),

                        _buildField(
                          'Password',
                          passwordController,
                          icon: Icons.lock_outline,
                          isPassword: true,
                        ),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              _showSnackbar(
                                context,
                                'Fitur lupa password akan segera hadir',
                              );
                            },
                            child: const Text(
                              'Lupa password?',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // BUTTON LOGIN
                        Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6DDC5C), Color(0xFF2E7D32)],
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              _handleLogin(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Masuk",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(Icons.arrow_forward),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        // BELUM PUNYA AKUN
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Belum punya akun?",
                              style: TextStyle(color: Colors.black54),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => RegisterPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Daftar",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.verified, color: Colors.green, size: 18),
                    SizedBox(width: 8),
                    Text(
                      "Aman, Terpercaya, dan Ramah Lingkungan",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller, {
    IconData? icon,
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: label,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.green.withOpacity(0.08),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.green),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.green, width: 2),
          ),
        ),
      ),
    );
  }

  void _handleLogin(BuildContext context) {
    String usernameEmail = usernameEmailController.text.trim();
    String password = passwordController.text;

    if (usernameEmail.isEmpty) {
      _showSnackbar(context, 'Username/Email tidak boleh kosong');
      return;
    }

    if (password.isEmpty) {
      _showSnackbar(context, 'Password tidak boleh kosong');
      return;
    }

    if (password.length < 6) {
      _showSnackbar(context, 'Password minimal 6 karakter');
      return;
    }

    var user = users.firstWhere(
      (u) => (u["username"] == usernameEmail) && (u["password"] == password),
      orElse: () => {},
    );

    if (user.isEmpty) {
      _showSnackbar(context, "Login gagal, akun tidak ditemukan");
      return;
    }

    String role = user["role"];
    String username = user["username"];
    String nomor = user["nomor"];

    String displayName = username[0].toUpperCase() + username.substring(1);

    if (role == "petugas") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DashboardPetugas(nama: displayName)),
      );
    } else if (role == "user") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => DashboardPage(
            username: displayName,
            userId: 1, // Assuming demo user id
          ),
        ),
      );
    } else {
      _showSnackbar(context, "Role tidak dikenali");
    }
  }

  // ✅ FIX ERROR UTAMA
  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
