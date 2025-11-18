import 'dart:io';

import 'package:project2/project2.dart' as project2;

void main(List<String> arguments) {
  // =========================================
  // 1. IF / ELSE + TERNARY
  // =========================================
  stdout.write("Masukkan nilai (0-100): ");
  String? input = stdin.readLineSync();
  int nilai = int.tryParse(input ?? "0") ?? 0;

  // IF/ELSE untuk cek lulus atau tidak
  if (nilai >= 60) {
    stdout.writeln("Hasil: LULUS");
  } else {
    stdout.writeln("Hasil: TIDAK LULUS");
  }

  // Ternary untuk tentukan grade
  String grade = (nilai > 80) ? "A" : (nilai >= 60 ? "B" : "C");
  stdout.writeln("Grade: $grade");

  // =========================================
  // 2. SWITCH CASE
  // =========================================
  int hari = 5;
  switch (hari) {
    case 1:
      stdout.writeln("Hari = Senin");
      break;
    case 2:
      stdout.writeln("Hari = Selasa");
      break;
    case 3:
      stdout.writeln("Hari = Rabu");
      break;
    case 4:
      stdout.writeln("Hari = Kamis");
      break;
    case 5:
      stdout.writeln("Hari = Jum'at");
      break;
    default:
      stdout.writeln("Hari tidak dikenali");
  }

  // =========================================
  // 3. EQUALITY CHECKING & TYPE COERCION
  // =========================================

  // Contoh menggunakan String
  String str1 = "halo";
  String str2 = "halo";
  String str3 =
      "ha" "lo"; // Dibuat lewat operasi string, bukan literal langsung

  // == membandingkan isi string (value equality)
  stdout.writeln("Apakah str1 == str2? ${str1 == str2}"); // true
  stdout.writeln("Apakah str1 == str3? ${str1 == str3}"); // true

  // identical membandingkan apakah objeknya sama persis di memori
  stdout.writeln(
    "Apakah str1 identik dengan str2? ${identical(str1, str2)}",
  ); // true (Dart optimisasi literal)
  stdout.writeln(
    "Apakah str1 identik dengan str3? ${identical(str1, str3)}",
  ); // bisa false (karena hasil operasi string)

  // Contoh TYPE COERCION (konversi tipe data)
  String teks = "123";
  int num = int.parse(teks); // ubah string jadi int
  stdout.writeln("String '$teks' diubah ke int = $num");

  // =========================================
  // 4. DO-WHILE dan WHILE
  // =========================================

  int i = 0;
  stdout.writeln("Perulangan while:");

  // WHILE LOOP
  // Mengecek kondisi dulu (i < 3), baru menjalankan isi perulangan
  // Jadi kalau dari awal kondisi salah → perulangan tidak dijalankan sama sekali
  while (i < 3) {
    stdout.writeln("i = $i");
    i++;
  }

  int j = 0;
  stdout.writeln("Perulangan do-while:");

  // DO-WHILE LOOP
  // Menjalankan isi perulangan dulu minimal sekali,
  // kemudian baru mengecek kondisi (j < 3)
  do {
    stdout.writeln("j = $j");
    j++;
  } while (j < 3);

  // =========================================
  // 5. FOR LOOP dengan BREAK dan CONTINUE
  // =========================================
  stdout.writeln("Perulangan for:");
  for (int k = 0; k < 6; k++) {
    if (k == 2) continue; // skip angka 2
    if (k == 4) break; // berhenti kalau k == 4
    stdout.writeln("k = $k");
  }
  // === Panggil fungsi kategori mahasiswa ===
  kategoriMahasiswa();
}

// =========================================
// Fungsi: Input 5 mahasiswa dan tentukan kategori nilai
// =========================================
void kategoriMahasiswa() {
  // List untuk menyimpan data mahasiswa
  List<Map<String, dynamic>> daftarMahasiswa = [];

  // Perulangan untuk input 5 mahasiswa
  for (int i = 1; i <= 5; i++) {
    stdout.writeln("\nMahasiswa ke-$i");

    // Input nama mahasiswa
    stdout.write("Masukkan nama: ");
    String? nama = stdin.readLineSync();

    // Input nilai mahasiswa
    stdout.write("Masukkan nilai: ");
    int nilai = int.parse(stdin.readLineSync()!);

    // Tentukan kategori berdasarkan nilai
    String kategori;
    if (nilai >= 80) {
      kategori = "A (Lulus)";
    } else if (nilai >= 60) {
      kategori = "B (Lulus)";
    } else {
      kategori = "C (Tidak Lulus)";
    }

    // Simpan ke list
    daftarMahasiswa.add({
      "nama": nama ?? "Tanpa Nama",
      "nilai": nilai,
      "kategori": kategori,
    });
  }

  // Tampilkan hasil akhir
  stdout.writeln("\n=== Daftar Mahasiswa dan Kategori ===");
  for (var mhs in daftarMahasiswa) {
    stdout.writeln(
      "Nama: ${mhs['nama']}, Nilai: ${mhs['nilai']}, Kategori: ${mhs['kategori']}",
    );
  }
}
