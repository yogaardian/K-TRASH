import 'package:flutter/material.dart';
import 'login.dart';
import 'data/user_data.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isPasswordHidden = true;
  bool isConfirmHidden = true;

  static int nomorCounter = 1;

  String generateNomor() {
    String nomor = nomorCounter.toString().padLeft(3, '0');
    nomorCounter++;
    return nomor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌿 BACKGROUND
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🌿 OVERLAY GRADIENT (biar soft)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.9),
                  Colors.green.withValues(alpha: 0.2),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60),

                // 🌿 LOGO
                Image.asset(
                  "assets/LogoK-Trash.png",
                  height: 160,
                ),

                const SizedBox(height: 20),

                // 🌿 CARD
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 25,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        // 🌿 TOGGLE
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF6DDC5C),
                                        Color(0xFF2E7D32)
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Text(
                                    "Daftar",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => LoginPage()),
                                    );
                                  },
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12),
                                    child: Text(
                                      "Login",
                                      textAlign: TextAlign.center,
                                      style:
                                          TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 25),

                        // 🌿 INPUT
                        _buildField("Username", usernameController,
                            icon: Icons.person_outline),
                        _buildField("Email", emailController,
                            icon: Icons.email_outlined),
                        _buildField("Nomor HP", phoneController,
                            icon: Icons.phone_outlined),

                        _buildField(
                          "Password",
                          passwordController,
                          icon: Icons.lock_outline,
                          isPassword: true,
                          isHidden: isPasswordHidden,
                          toggle: () {
                            setState(() {
                              isPasswordHidden = !isPasswordHidden;
                            });
                          },
                        ),

                        _buildField(
                          "Konfirmasi Password",
                          confirmPasswordController,
                          icon: Icons.lock_outline,
                          isPassword: true,
                          isHidden: isConfirmHidden,
                          toggle: () {
                            setState(() {
                              isConfirmHidden = !isConfirmHidden;
                            });
                          },
                        ),

                        const SizedBox(height: 25),

                        // 🌿 BUTTON GRADIENT (INI KUNCI BIAR BAGUS)
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF6DDC5C),
                                  Color(0xFF2E7D32)
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green.withValues(alpha: 0.4),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                )
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () => _handleRegister(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Daftar",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(Icons.arrow_forward,
                                      color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // 🌿 FOOTER
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.verified,
                                color: Colors.green, size: 18),
                            SizedBox(width: 8),
                            Text(
                              "Aman, Terpercaya, dan Ramah Lingkungan",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🌿 FIELD
  Widget _buildField(
    String label,
    TextEditingController controller, {
    IconData? icon,
    bool isPassword = false,
    bool isHidden = false,
    VoidCallback? toggle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? isHidden : false,
        decoration: InputDecoration(
          hintText: label,
          prefixIcon: Icon(icon),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isHidden ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: toggle,
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.green),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide:
                const BorderSide(color: Colors.green, width: 2),
          ),
        ),
      ),
    );
  }

  // 🌿 REGISTER LOGIC
  void _handleRegister(BuildContext context) {
    String username = usernameController.text.trim();
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showSnackbar(context, 'Isi semua data');
      return;
    }

    if (password != confirmPassword) {
      _showSnackbar(context, 'Password tidak sama');
      return;
    }

    String nomorUser = generateNomor();

    users.add({
      "username": username,
      "password": password,
      "role": "user",
      "nomor": nomorUser,
    });

    _showSnackbar(context, 'Registrasi berhasil');

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginPage()),
      );
    });
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}