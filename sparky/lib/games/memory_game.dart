import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MemoryGame extends StatefulWidget {
  const MemoryGame({super.key});

  @override
  _MemoryGameState createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Kart çiftleri
  final List<String> cardPairs = [
    '🐶',
    '🐶',
    '🐱',
    '🐱',
    '🐭',
    '🐭',
    '🐹',
    '🐹',
    '🐰',
    '🐰',
    '🦊',
    '🦊',
    '🐻',
    '🐻',
    '🐼',
    '🐼',
  ];

  List<String> cards = [];
  List<int> selectedIndices = [];
  List<bool> matchedCards = []; // Eşleşen kartları takip etmek için
  int pairsFound = 0;
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    setState(() {
      cards = List.from(cardPairs)..shuffle();
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
      if (cards[selectedIndices[0]] == cards[selectedIndices[1]]) {
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            matchedCards[selectedIndices[0]] = true;
            matchedCards[selectedIndices[1]] = true;
            pairsFound++;
            selectedIndices.clear();
            play("Correct");
            isProcessing = false;
          });

          if (pairsFound == cardPairs.length ~/ 2) {
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
          crossAxisCount: 4,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.8,
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
                          cards[index],
                          style: const TextStyle(fontSize: 36),
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
