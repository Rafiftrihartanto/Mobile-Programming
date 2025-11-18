import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Add this line

void main() {
  runApp(const Percobaan2());
}

// class Percobaan1 extends StatelessWidget {
//   const Percobaan1({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Mata Kuluah Satria Rakhmadani",
//       home: Scaffold(
//         appBar: AppBar(
//             title: Text(
//             "Satria Rakhmadani",
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//             ),
//           backgroundColor: Colors.blueAccent,
//           foregroundColor: Colors.yellow,
//           centerTitle: true,
//         ),
//         body: Align(
//           alignment: Alignment.topLeft,
//           child: Column(
//             // crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Align(
//                 alignment: Alignment.topCenter,
//                 child: Column(
//                   children: [
//                     Text("Balonku Ada Lima"),
//                     Text("A.T. Mahmud"),
//                   ],
//                 )
//               ),
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Column(
//                   children: [
//                     Text("Balonku ada lima \nRupa-rupa warnanya \nHijau, kuning, kelabu \nMerah muda dan biru"),
//                   ],
//                 )
//               ),
//               Align(
//                 alignment: Alignment.topRight,
//                 child: Column(
//                   children: [
//                     Text("Meletus balon hijau \nDOOOOR.... \nHatiku sangat kacau \nBalonku tinggal empat \nKupegang erat-erat"),
//                     Text("Meletus balon hijau \nDOOOOR.... \nHatiku sangat kacau \nBalonku tinggal empat \nKupegang erat-erat"),
//                   ],
//                 )
//               ),
//             ],
//           ),  
//         ),
//       ),
//     );
//   }
// }



class Percobaan2 extends StatelessWidget {
  const Percobaan2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mata Kuliah Satria Rakhmadani",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: GoogleFonts.poppinsTextTheme(), // Use Google Fonts
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "MyMusic App Name",
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Text(
                        "My Way",
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                      Text(
                        "Frank Sinatra",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: Colors.indigo[300],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.topCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/myway.jpg',
                      width: 180,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "And now, the end is near\nAnd so I face the final curtain\nMy friend, I'll say it clear\nI'll state my case, of which I'm certain\nI've lived a life that's full\nI traveled each and every highway\nAnd more, much more than this, I did it my way",
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Regrets, I've had a few\nBut then again, too few to mention\nI did what I had to do And saw it through without exemption\nI planned each charted course\nEach careful step along the byway\nAnd more, much more than this, I did it my way",
                    style: GoogleFonts.poppins(fontSize: 16),
                    textAlign: TextAlign.right,
                  ),
                  ),
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Yes, there were times, I'm sure you knew\nWhen I bit off more than I could chew\nBut through it all, when there was doubt\nI ate it up and spit it out\nI faced it all and I stood tall and did it my way",
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "I've loved, I've laughed and cried\nI've had my fill, my share of losing\nAnd now, as tears subside\nI find it all so amusing\nTo think I did all that\nAnd may I say, not in a shy way\nOh no, oh no, not me, I did it my way",
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "For what is a man, what has he got?\nIf not himself, then he has naught\nTo say the things he truly feels\nAnd not the words of one who kneels\nThe record shows I took the blows\nAnd did it my way",
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Yes, it was my way",
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
