import 'package:flutter/material.dart';
import 'package:sparky/games/memory_game.dart';
import 'screens/chat_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sparky',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MemoryGame(),
    );
  }
}
