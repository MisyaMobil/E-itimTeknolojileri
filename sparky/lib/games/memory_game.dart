import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/services.dart';

class MemoryGame extends StatefulWidget {
  const MemoryGame({super.key});

  @override
  _MemoryGameState createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Türkçe - İngilizce kelime çiftleri (ikili kartlar)
  final List<Map<String, String>> cardPairs = [
    {'Türkçe': 'Köpek', 'İngilizce': 'Dog'},
    {'Türkçe': 'Kedi', 'İngilizce': 'Cat'},
    {'Türkçe': 'Fare', 'İngilizce': 'Mouse'},
    {'Türkçe': 'Kuş', 'İngilizce': 'Bird'},
    {'Türkçe': 'Ayı', 'İngilizce': 'Bear'},
    {'Türkçe': 'Araba', 'İngilizce': 'Car'},
    {'Türkçe': 'Masa', 'İngilizce': 'Table'},
    {'Türkçe': 'Bilgisayar', 'İngilizce': 'Computer'},
    {'Türkçe': 'Kalem', 'İngilizce': 'Pencil'},
  ];

  List<Map<String, String>> cards = [];
  List<int> selectedIndices = [];
  List<bool> matchedCards = [];
  int pairsFound = 0;
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    startGame();
  }

  void startGame() {
    setState(() {
      // Kart çiftlerini karıştırıp oluşturuyoruz
      cards = [];
      for (var pair in cardPairs) {
        cards.add({
          "Kelime": pair["Türkçe"]!,
          "Anlam": pair["İngilizce"]!,
        }); // Türkçe kart
        cards.add({
          "Kelime": pair["İngilizce"]!,
          "Anlam": pair["Türkçe"]!,
        }); // İngilizce kart
      }
      cards.shuffle(); // Kartları karıştırıyoruz
      selectedIndices = [];
      matchedCards = List.filled(cards.length, false);
      pairsFound = 0;
    });
  }

  void play(String fileName) {
    _audioPlayer
        .setAsset('assets/sounds/$fileName.mp3')
        .then((_) {
          _audioPlayer.play();
        })
        .catchError((e) {
          print('Ses oynatma hatası: $e');
        });
  }

  void handleCardClick(int index) {
    if (isProcessing ||
        selectedIndices.contains(index) ||
        matchedCards[index]) {
      return;
    }

    setState(() {
      selectedIndices.add(index);
    });

    play("CardFlip");
    if (selectedIndices.length == 2) {
      isProcessing = true;
      // Türkçe - İngilizce eşleşmesi kontrolü
      if ((cards[selectedIndices[0]]['Kelime'] ==
          cards[selectedIndices[1]]['Anlam'])) {
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            matchedCards[selectedIndices[0]] = true;
            matchedCards[selectedIndices[1]] = true;
            pairsFound++;
            selectedIndices.clear();
            play("Correct");
            isProcessing = false;
          });

          if (pairsFound == cardPairs.length) {
            showGameWonDialog();
          }
        });
      } else {
        Future.delayed(const Duration(milliseconds: 1000), () {
          setState(() {
            selectedIndices.clear();
            isProcessing = false;
          });
        });
      }
    }
  }

  void showGameWonDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Tebrikler!'),
            content: const Text('Tüm eşleşmeleri buldunuz!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  startGame();
                },
                child: const Text('Tekrar Oyna'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hafıza Oyunu'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: startGame),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 4 sütun olacak
          childAspectRatio: 1, // Kartlar kare şeklinde olacak
        ),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          if (matchedCards[index]) {
            return Container(); // Eşleşen kartları boş container ile değiştir
          }

          return GestureDetector(
            onTap: () => handleCardClick(index),
            child: Card(
              elevation: 4,
              color:
                  selectedIndices.contains(index) ? Colors.white : Colors.blue,
              child: Center(
                child:
                    selectedIndices.contains(index)
                        ? Text(
                          cards[index]['Kelime'] ?? '',
                          style: const TextStyle(fontSize: 24),
                        )
                        : const Text('?', style: TextStyle(fontSize: 24)),
              ),
            ),
          );
        },
      ),
    );
  }
}
