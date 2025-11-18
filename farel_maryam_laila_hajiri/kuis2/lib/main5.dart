import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const PokeApp());
}

class PokeApp extends StatelessWidget {
  const PokeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeAPI Demo',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const PokemonPage(),
    ); // MaterialApp
  }
}

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key});

  @override
  _PokemonPageState createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  // State untuk menyimpan data
  Map<String, dynamic>? pokemonData;
  bool isLoading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    // Otomatis ambil data saat pertama kali dimuat
    fetchPokemon(); 
  }

  // --- Fungsi untuk Mengambil Data Pokemon ---
  Future<void> fetchPokemon() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final response = await http
          .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/ditto'))
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        setState(() {
          pokemonData = jsonDecode(response.body) as Map<String, dynamic>;
        });
      } else {
        setState(() {
          error = 'Gagal memuat data. Status: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        error = 'Terjadi kesalahan: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // --- Widget Card Tampilan Pokemon ---
  Widget _buildPokemonCard() {
    if (isLoading) {
      return const CircularProgressIndicator();
    }

    if (error != null) {
      return Text(error!, style: const TextStyle(color: Colors.red));
    }
    
    // Tampilkan pesan jika data kosong (setelah loading/error)
    if (pokemonData == null) {
      return const Text('Tekan tombol refresh untuk memuat data.');
    }

    // Ekstraksi data
    final name = pokemonData!['name'] ?? '-';
    final id = pokemonData!['id'] ?? '-';
    // Data height dan weight biasanya dalam desimeter/hektogram, tapi di sini ditampilkan mentah
    final height = pokemonData!['height'] ?? '-'; 
    final weight = pokemonData!['weight'] ?? '-';
    // Ambil URL sprite, fallback ke placeholder jika tidak ada
    final sprite = pokemonData!['sprites']?['front_default'] ?? 'https://via.placeholder.com/150';

    return Card(
      margin: const EdgeInsets.all(20),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.network(sprite, width: 150, height: 150),
            const SizedBox(height: 10),
            Text(
              name.toString().toUpperCase(),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 8),
            Text('ID: $id'),
            Text('Height: $height'),
            Text('Weight: $weight'),
          ],
        ),
      ),
    ); // Card
  }

  // --- Build UI Halaman ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PokeAPI - Ditto')),
      body: Center(child: _buildPokemonCard()),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchPokemon,
        tooltip: 'Refresh Data',
        child: const Icon(Icons.refresh),
      ), // FloatingActionButton
    ); // Scaffold
  }
}