import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:sparky/games/memory_game.dart';
=======
import 'package:sparky/screens/auth/profile.dart';
import 'screens/auth/login.dart';
import 'screens/auth/register.dart';
import 'screens/auth/giris_yap.dart';
>>>>>>> emir
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
<<<<<<< HEAD
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MemoryGame(),
=======
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF87CEEB),
      ),
      // İlk açılış sayfası olarak login sayfasını ayarladık
      initialRoute: '/login',
      routes: {
        '/': (context) => const MainMenu(),
        '/login': (context) => const Giris(),
        '/register': (context) => const KayitOl(),
        '/giris_yap': (context) => const GirisYap(),
        '/chat': (context) => ChatScreen(),
        '/main_menu': (context) => const MainMenu(),
        '/profile': (context) => const ProfilSayfasi(),
      },
>>>>>>> emir
    );
  }
}
