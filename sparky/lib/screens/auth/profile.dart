import 'package:flutter/material.dart';

class ProfilSayfasi extends StatelessWidget {
  const ProfilSayfasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.sports_esports), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: const BoxDecoration(
              color: const Color(0xFF4252B4),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Center(
              child: Text(
                'PROFİL',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.bottomRight,
            children: const [
              CircleAvatar(radius: 50, backgroundColor: Colors.grey),
              Positioned(
                bottom: 0,
                right: 4,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.add, size: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'İsim Soyad',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          const _ProfilBilgiKarti(icon: Icons.person, text: 'Kullanıcı Adı'),
          const _ProfilBilgiKarti(icon: Icons.email, text: 'E-Posta'),
          const _ProfilBilgiKarti(icon: Icons.bookmark, text: 'Sınıf'),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFEAF4FE),
                foregroundColor: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 20,
                ),
                elevation: 0,
              ),
              onPressed: () {
                print('Profil Düzenle tıklandı');
                // Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilDuzenleSayfasi()));
              },
              icon: const Icon(Icons.edit),
              label: const Text(
                'Profil Düzenle',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfilBilgiKarti extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ProfilBilgiKarti({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFEAF4FE),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black54),
            const SizedBox(width: 16),
            Text(text, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
