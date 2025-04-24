import 'package:flutter/material.dart';
import 'screens/auth/login.dart';
import 'screens/auth/register.dart';
import 'screens/auth/giris_yap.dart';
import 'screens/chat_screen.dart';
import 'screens/auth/main_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sparky',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF87CEEB),
      ),
      // İlk açılış sayfası olarak MainMenu sayfasını ayarlıyoruz
      initialRoute: '/',
      routes: {
        '/': (context) => const MainMenu(), // Ana menü sayfası
        '/login': (context) => const Giris(), // Giriş sayfası
        '/register': (context) => const KayitOl(), // Kayıt ol sayfası
        '/giris_yap': (context) => const GirisYap(), // Giriş yap sayfası
        '/chat': (context) => ChatScreen(), // Chat ekranı
      },
    );
  }
}
