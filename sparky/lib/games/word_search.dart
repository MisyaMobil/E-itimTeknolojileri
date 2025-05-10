import 'dart:math';

import 'package:flutter/material.dart';

class WordSearch extends StatefulWidget {
  const WordSearch({super.key});

  @override
  State<WordSearch> createState() => _WordSearchState();
}

class _WordSearchState extends State<WordSearch> {
  // The grid with initial empty spaces
  final List<List<String>> grid = List.generate(
    10,
    (_) => List.generate(10, (_) => ' '),
  );

  final List<String> words = ['FISH', 'FEAR', 'BEAR', 'CROW', 'CAT', 'DOG'];

  final List<Offset> selectedCells = [];
  final List<List<Offset>> foundWords = [];

  final GlobalKey _gridKey = GlobalKey();
  double cellSize = 35.0;

  Offset? lastCell;

  String? direction; // 'row' or 'col'

  bool get isGameOver {
    final foundWordList =
        foundWords.map((w) {
          final formed = w.map((c) => grid[c.dy.toInt()][c.dx.toInt()]).join();
          return formed;
        }).toList();

    return words.every(
      (word) =>
          foundWordList.contains(word) ||
          foundWordList.contains(word.split('').reversed.join()),
    );
  }

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  // Helper function to place a word in the grid either horizontally or vertically
  bool placeWord(String word) {
    Random random = Random();
    bool placed = false;

    while (!placed) {
      int direction = random.nextInt(2); // 0 = horizontal, 1 = vertical
      int row = random.nextInt(grid.length);
      int col = random.nextInt(grid[0].length);

      if (direction == 0 && col + word.length <= grid[0].length) {
        // Try horizontal placement
        bool canPlace = true;
        for (int i = 0; i < word.length; i++) {
          if (grid[row][col + i] != ' ' && grid[row][col + i] != word[i]) {
            canPlace = false;
            break;
          }
        }

        if (canPlace) {
          for (int i = 0; i < word.length; i++) {
            grid[row][col + i] = word[i];
          }
          placed = true;
        }
      } else if (direction == 1 && row + word.length <= grid.length) {
        // Try vertical placement
        bool canPlace = true;
        for (int i = 0; i < word.length; i++) {
          if (grid[row + i][col] != ' ' && grid[row + i][col] != word[i]) {
            canPlace = false;
            break;
          }
        }

        if (canPlace) {
          for (int i = 0; i < word.length; i++) {
            grid[row + i][col] = word[i];
          }
          placed = true;
        }
      }
    }

    return true;
  }

  // Place all words in the grid
  void _placeWordsInGrid() {
    // Shuffle the word list to randomize the placement order
    words.shuffle();

    for (String word in words) {
      placeWord(word);
    }
  }

  // Fill the remaining empty spaces with random letters
  void _fillEmptySpaces() {
    Random random = Random();
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    for (int row = 0; row < grid.length; row++) {
      for (int col = 0; col < grid[row].length; col++) {
        if (grid[row][col] == ' ') {
          grid[row][col] = letters[random.nextInt(letters.length)];
        }
      }
    }
  }

  // Reset the grid and start a new game
  void _resetGame() {
    // Reset the grid to be empty
    for (int row = 0; row < grid.length; row++) {
      for (int col = 0; col < grid[row].length; col++) {
        grid[row][col] = ' ';
      }
    }

    // Place the words in the grid
    _placeWordsInGrid();
    // Fill the remaining empty spaces with random letters
    _fillEmptySpaces();
    // Clear selected cells and found words
    selectedCells.clear();
    foundWords.clear();
  }

  void _handlePan(Offset globalPosition) {
    final RenderBox? box =
        _gridKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;

    final local = box.globalToLocal(globalPosition);
    final col = (local.dx / cellSize).floor();
    final row = (local.dy / cellSize).floor();

    if (row < 0 || row >= grid.length || col < 0 || col >= grid[0].length)
      return;

    final cell = Offset(col.toDouble(), row.toDouble());
    if (cell == lastCell || selectedCells.contains(cell)) return;

    if (selectedCells.isEmpty) {
      direction = null;
      selectedCells.add(cell);
      lastCell = cell;
      setState(() {});
      return;
    }

    if (selectedCells.length == 1) {
      if (cell.dx == selectedCells[0].dx) {
        direction = 'col';
      } else if (cell.dy == selectedCells[0].dy) {
        direction = 'row';
      } else {
        return;
      }
    }

    if (direction == 'row' && cell.dy != selectedCells[0].dy) return;
    if (direction == 'col' && cell.dx != selectedCells[0].dx) return;

    selectedCells.add(cell);
    lastCell = cell;
    setState(() {});
  }

  void _handlePanEnd() {
    final word =
        selectedCells.map((c) => grid[c.dy.toInt()][c.dx.toInt()]).join();
    final reversed = word.split('').reversed.join();

    if (words.contains(word) || words.contains(reversed)) {
      setState(() {
        foundWords.add(List.from(selectedCells));
      });
    }

    setState(() {
      selectedCells.clear();
      lastCell = null;
      direction = null;
    });
  }

  bool _isSelected(int x, int y) {
    return selectedCells.contains(Offset(x.toDouble(), y.toDouble()));
  }

  bool _isFound(int x, int y) {
    return foundWords.any(
      (w) => w.contains(Offset(x.toDouble(), y.toDouble())),
    );
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Oyun Bitti'),
          content: const Text('Tebrikler, tüm kelimeleri buldunuz!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _resetGame();
                });
              },
              child: const Text('Tekrar Oyna'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ana Sayfaya Dön'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isGameOver) {
      Future.delayed(Duration.zero, () {
        _showGameOverDialog();
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Kelime Bulmaca"), centerTitle: true),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: Center(
              child: GestureDetector(
                onPanStart: (details) => _handlePan(details.globalPosition),
                onPanUpdate: (details) => _handlePan(details.globalPosition),
                onPanEnd: (_) => _handlePanEnd(),
                child: Container(
                  key: _gridKey,
                  color: Colors.white,
                  padding: const EdgeInsets.all(2),
                  height: grid.length * cellSize + (grid.length * 3),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(grid.length, (row) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(grid[row].length, (col) {
                          final selected = _isSelected(col, row);
                          final found = _isFound(col, row);
                          return Container(
                            width: cellSize,
                            height: cellSize,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color:
                                  found
                                      ? Colors.greenAccent
                                      : selected
                                      ? Colors.yellow
                                      : Colors.blue[50],
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Text(
                              grid[row][col],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    words.map((word) {
                      final isFound = foundWords.any((cells) {
                        final formed =
                            cells
                                .map((c) => grid[c.dy.toInt()][c.dx.toInt()])
                                .join();
                        final reversed = formed.split('').reversed.join();
                        return formed == word || reversed == word;
                      });
                      return Chip(
                        label: Text(word),
                        backgroundColor: isFound ? Colors.green : null,
                      );
                    }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
