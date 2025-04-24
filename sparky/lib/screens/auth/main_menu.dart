import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF87CEEB), // Açık mavi arka plan
      appBar: AppBar(
        title: const Text(
          'ANA MENÜ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Logo Container
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xFF87CEEB), // Arka plan ile aynı renk
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/sparky_logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Menü butonları grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: [
                  _buildMenuButton('Kelime Öğren', Icons.book, () {
                    // Kelime öğren sayfasına yönlendirme
                  }),
                  _buildMenuButton('Yapay Zeka\nSparky', Icons.smart_toy, () {
                    // Yapay zeka sayfasına yönlendirme
                  }),
                  _buildMenuButton('Okuma Metni', Icons.menu_book, () {
                    // Okuma metni sayfasına yönlendirme
                  }),
                  _buildMenuButton('Video İzle', Icons.play_circle_fill, () {
                    // Video izle sayfasına yönlendirme
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: 1, // Ana sayfa seçili
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.games), label: 'Oyun'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        onTap: (index) {
          // Navigation bar item'larına tıklandığında yapılacak işlemler
        },
      ),
    );
  }

  Widget _buildMenuButton(String title, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF7A4DFF), // Yeni mor renk
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.all(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: const Color(0xFFFF9A15), // Turuncu ikon rengi
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFFF9A15), // Turuncu yazı rengi
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
