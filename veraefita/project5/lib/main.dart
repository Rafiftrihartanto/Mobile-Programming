// import 'package:flutter/material.dart';

// void main() {
//   runApp(const sib3a());
// }

// class sib3a extends StatelessWidget {
//   const sib3a({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Row(
//             //jika menggunakan column maka subtitle akan berada di bawah tulisan flutternya haura, jika menggunakan row, maka tulisan subtitle berada di samping tulisan flutternya haura
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Icon(
//                 Icons.account_circle,
//                 size: 48,
//                 color: Colors.white,
//               ), //icon bisa ditambahkan karena didalam array
//               const Text(
//                 'Flutternya vera',
//                 style: TextStyle(fontSize: 24, color: Colors.white),
//               ),
//               const Text(
//                 'Subtitle',
//                 style: TextStyle(fontSize: 14, color: Colors.white),
//               ),
//               const FlutterLogo(
//                 size: 48,
//                 style: FlutterLogoStyle.horizontal,
//                 textColor: Colors.white,
//               ),
//               Image.asset('assets/images/poltek.jpeg', width: 48, height: 48),
//             ],
//           ),
//           backgroundColor: Colors.purple,
//           // leading: const Icon(Icons.menu),
//           actions: const [Icon(Icons.search), Icon(Icons.settings)],
//         ),
//         body: Container(
//           margin: const EdgeInsets.all(10),
//           padding: const EdgeInsets.all(10),
//           alignment: Alignment.center,
//           // color: Colors.red,
//           height: 250,
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(
//               colors: [Colors.purple, Colors.deepPurple],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             // color: Colors.blue,
//             border: Border.all(color: Colors.black),
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: const [
//               BoxShadow(
//                 color: Color.fromARGB(255, 23, 23, 23),
//                 offset: Offset(2, 2),
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Text('You have ...'),
//               const Row(
//                 //jika menggunakan row, maka bintang bintangnya menyamping, jika menggunakan column maka bintang bintangnya berjajar kebawh
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.star, color: Colors.amber),
//                   Icon(Icons.star, color: Colors.amber),
//                   Icon(Icons.star, color: Colors.amber),
//                   Icon(Icons.star_half, color: Colors.amber),
//                   Icon(Icons.star_border, color: Colors.amber),
//                 ],
//               ),
//               ElevatedButton(onPressed: () {}, child: const Text('Klik here')),
//               TextButton(
//                 onPressed: () {
//                   print('Text button pressed');
//                 },
//                 child: const Text(
//                   'Text Button',
//                   style: TextStyle(fontSize: 16, color: Colors.white),
//                 ),
//               ),
//               OutlinedButton(
//                 onPressed: () {},
//                 child: const Text(
//                   'Klik here',
//                   style: TextStyle(fontSize: 16, color: Colors.white),
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   print('Icon button pressed');
//                 },
//                 icon: const Icon(Icons.favorite, color: Colors.red),
//               ),
//             ],
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {}, //untuk memberi action next or back or something
//           tooltip: 'ini tombol',
//           child: const Icon(Icons.add),
//         ),
//         drawer: Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: const [
//               DrawerHeader(
//                 decoration: BoxDecoration(color: Colors.blue),
//                 child: Text(
//                   'Drawer Header',
//                   style: TextStyle(color: Colors.white, fontSize: 24),
//                 ),
//               ),
//               ListTile(leading: Icon(Icons.message), title: Text('Messages')),
//               ListTile(
//                 leading: Icon(Icons.account_circle),
//                 title: Text('Profile'),
//               ),
//               ListTile(leading: Icon(Icons.settings), title: Text('Settings')),
//             ],
//           ),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.business),
//               label: 'Business',
//             ),
//             BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Profile & Counter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 78, 20, 225),
          foregroundColor: Colors.white,
        ),
      ),
      home: const MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  // PINDAHKAN: State counter dipindahkan ke sini
  int _counter = 0; 

  // FUNGSI BARU: Fungsi untuk mengubah state counter
  void _increment() => setState(() => _counter++);
  void _decrement() => setState(() => _counter--);
  void _reset() => setState(() => _counter = 0);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 1. Buat list pages di dalam build() agar CounterPage selalu mendapat data terbaru
    final List<Widget> pages = [
      const ProfilePage(),
      // 2. KIRIM data dan fungsi ke CounterPage melalui constructor
      CounterPage(
        currentCounter: _counter,
        incrementFunction: _increment,
        decrementFunction: _decrement,
        resetFunction: _reset,
      ),
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 26, 45, 251),
              Color.fromARGB(255, 255, 248, 255),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        // Gunakan list pages yang sudah diperbarui
        child: pages[_selectedIndex],
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color.fromARGB(255, 10, 18, 130),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: "Counter"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      
      // PERBAIKAN: Floating Action Button sekarang memanggil fungsi yang benar
      floatingActionButton: FloatingActionButton(
        onPressed: _increment, // Terhubung ke fungsi _increment di _MainPageState
        tooltip: 'Tambah angka',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ======================
// 1️⃣ Halaman Profil (Tidak ada perubahan fungsi, hanya styling)
// ======================
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text("Profil Mahasiswa"),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 21, 101, 239),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            // Warna container profil (terang) dan semi-transparan
            color: const Color.fromARGB(255, 26, 45, 251).withOpacity(0.6), 
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ❌ BARIS FlutterLogo TELAH DIHAPUS DI SINI
              
              // Jarak 10 pixel dipertahankan
              const SizedBox(height: 10), 
              
              ClipOval(
                child: Image.asset(
                  'assets/images/poltek.jpeg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Vera Efita Hudi Putri',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const Text(
                'NIM: 2341760047',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const Text(
                'Jurusan Teknologi Informasi',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 15),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.email, color: Colors.white70),
                  SizedBox(width: 8),
                  Text('veraefita05@email.com', style: TextStyle(color: Colors.white70)),
                  SizedBox(width: 20),
                  Icon(Icons.phone, color: Colors.white70),
                  SizedBox(width: 8),
                  Text('0896-2606-5619', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ======================
// 2️⃣ Halaman Counter (Diubah menjadi StatelessWidget, menerima fungsi dari MainPage)
// ======================
class CounterPage extends StatelessWidget {
  // Menerima data dan fungsi melalui constructor
  final int currentCounter;
  final VoidCallback incrementFunction;
  final VoidCallback decrementFunction;
  final VoidCallback resetFunction;

  const CounterPage({
    super.key,
    required this.currentCounter,
    required this.incrementFunction,
    required this.decrementFunction,
    required this.resetFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, 
      appBar: AppBar(
        title: const Text('Counter App'),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 21, 101, 239),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Angka saat ini:',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              // GUNAKAN: Menggunakan data yang diterima
              '$currentCounter',
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // PANGGIL: Memanggil fungsi yang diterima dari MainPage
                ElevatedButton(onPressed: incrementFunction, child: const Text('+')),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: decrementFunction, child: const Text('-')),
                const SizedBox(width: 10),
                OutlinedButton(onPressed: resetFunction, child: const Text('Reset')),
              ],
            ),
          ],
        ),
      ),
      // Hapus FloatingActionButton di sini karena sudah dipindahkan ke MainPage
    );
  }
}