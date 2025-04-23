import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FindInImage extends StatefulWidget {
  const FindInImage({super.key});

  @override
  State<FindInImage> createState() => _FindInImageState();
}

class _FindInImageState extends State<FindInImage> {
  Offset? _tapPosition;

  final List<Map<String, dynamic>> clickableAreas = [
    {'id': 'Apple', 'rect': Rect.fromLTWH(80, 100, 100, 100)},
    {'id': 'Banana', 'rect': Rect.fromLTWH(300, 200, 120, 120)},
    {'id': 'Cherry', 'rect': Rect.fromLTWH(600, 150, 100, 100)},
  ];

  List<String> wordsToFind = ['Apple', 'Banana', 'Cherry'];

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    final tapPos = details.localPosition;
    setState(() {
      _tapPosition = tapPos;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTapDown: _handleTapDown,
            child: SizedBox(
              width: screenSize.width,
              height: screenSize.height,
              child: Image.asset(
                'assets/images/example.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          if (_tapPosition != null)
            Positioned(
              left: _tapPosition!.dx,
              top: _tapPosition!.dy,
              child: const Icon(Icons.circle, size: 10, color: Colors.red),
            ),

          // ALTTA ORTALANMIŞ KELİMELER (ekranın yatay alt kenarına)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children:
                    wordsToFind.map((word) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          word,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
