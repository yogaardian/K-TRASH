import 'package:flutter/material.dart';
import 'intro_video_page.dart';
import 'login.dart';
import 'register.dart';

void main() {
  runApp(const KTrashApp());
}

class KTrashApp extends StatelessWidget {
  const KTrashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'K-TRASH',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const IntroVideoPage(),
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => LoginPage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLoggedIn = false;
  int selectedButton = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
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
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(45),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.15),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Image.asset('assets/LogoK-Trash.png', height: 180),
                  ),
                  const SizedBox(height: 60),
                  if (!isLoggedIn) ...[
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: selectedButton == 1
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFF6DDC5C),
                                    Color(0xFF2E7D32),
                                  ],
                                )
                              : null,
                          color: selectedButton == 1 ? null : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color(0xFF6DDC5C),
                            width: 1.5,
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              selectedButton = 1;
                            });
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                            setState(() {
                              isLoggedIn = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Masuk',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: selectedButton == 1
                                      ? Colors.white
                                      : const Color(0xFF2E7D32),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Icon(
                                Icons.arrow_forward,
                                color: selectedButton == 1
                                    ? Colors.white
                                    : const Color(0xFF2E7D32),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: selectedButton == 2
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFF6DDC5C),
                                    Color(0xFF2E7D32),
                                  ],
                                )
                              : null,
                          color: selectedButton == 2 ? null : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color(0xFF6DDC5C),
                            width: 1.5,
                          ),
                        ),
                        child: OutlinedButton(
                          onPressed: () async {
                            setState(() {
                              selectedButton = 2;
                            });
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ),
                            );
                            setState(() {
                              isLoggedIn = true;
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Daftar Sekarang',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: selectedButton == 2
                                      ? Colors.white
                                      : const Color(0xFF2E7D32),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Icon(
                                Icons.arrow_forward,
                                color: selectedButton == 2
                                    ? Colors.white
                                    : const Color(0xFF2E7D32),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (isLoggedIn)
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'Selamat datang kembali 👋',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.verified,
                        color: Color(0xFF6DDC5C),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Aman, Terpercaya, dan Ramah Lingkungan',
                        style: TextStyle(color: Colors.grey[700], fontSize: 12),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
