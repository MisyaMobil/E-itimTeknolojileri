import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF87CEEB),
      appBar: AppBar(
        title: const Text(
          'ANA MENÜ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF4252B4),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF87CEEB),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Logo Container
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.35,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset(
                'assets/images/sparky_logo.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 30),
            // Menu buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildMenuButton(
                          'Kelime Öğren',
                          'assets/icons/abc_icon.png',
                          () {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildMenuButton(
                          'Yapay Zeka\nSparky',
                          'assets/icons/robot_icon.png',
                          () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMenuButton(
                          'Okuma Metni',
                          'assets/icons/book_icon.png',
                          () {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildMenuButton(
                          'Video İzle',
                          'assets/icons/video_icon.png',
                          () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Game Controller Icon
            IconButton(
              icon: const Icon(
                Icons.sports_esports_outlined,
                size: 28,
                color: Colors.black54,
              ),
              onPressed: () {},
            ),
            // Home Button with blue circle background
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFF4A90E2),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4A90E2).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.home_rounded,
                  color: Colors.white,
                  size: 32,
                ),
                onPressed: () {},
              ),
            ),
            // Profile Icon
            IconButton(
              icon: const Icon(
                Icons.person_outline,
                size: 28,
                color: Colors.black54,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    String title,
    String iconPath,
    VoidCallback onPressed,
  ) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFF8A4DFF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getIconData(iconPath),
                size: 32,
                color: const Color(0xFFFFB74D),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFFFB74D),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconData(String iconPath) {
    // Temporary icon mapping until we have actual assets
    switch (iconPath) {
      case 'assets/icons/abc_icon.png':
        return Icons.abc;
      case 'assets/icons/robot_icon.png':
        return Icons.smart_toy;
      case 'assets/icons/book_icon.png':
        return Icons.menu_book;
      case 'assets/icons/video_icon.png':
        return Icons.play_circle_outline;
      default:
        return Icons.error;
    }
  }
}
