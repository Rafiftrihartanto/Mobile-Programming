import 'dart:io';
import 'package:project1/project1.dart' as project1;

void main(List<String> arguments) {
  print('Hello world: ${project1.calculate()}!');

  // 1. COMMENTS
  // -----------------------
  // Ini adalah single-line comment
  /* Ini adalah 
     multi-line comment */
  /// Ini adalah documentation comment (biasanya untuk docs otomatis)
  // -----------------------
  // 2. VARIABLES
  // -----------------------
  var name = "Farel Maryam Laila Hajiri";
  stdout.writeln("Nama: $name");
  // -----------------------
  // 3. CONSTANTS & FINAL
  // -----------------------
  final currentYear = 2025; // runtime constant
  const pi = 3.14285;       // compile-time constant
  stdout.writeln("Tahun: $currentYear, Pi: $pi");
  // -----------------------
  // 4. DATA TYPES
  // -----------------------
  int age = 2;
  double height = 165.5;
  num weight = 48;
  bool isStudent = true;
  String greeting = "Halo, Dunia!";
  List<String> hobbies = ["Coding", "Gaming", "Traveling"];
  Map<String, String> capital = {"Indonesia": "Jakarta", "Japan": "Tokyo"};
  dynamic anything = "Bisa berubah";
  anything = 123;
  stdout.writeln("Umur: $age, Tinggi: $height, Berat: $weight, Student: $isStudent");
  stdout.writeln("Hobi: $hobbies, Ibu kota: $capital, Dynamic: $anything");
  // -----------------------
  // 5. NUMBERS
  // -----------------------
  int a = 12;
  double b = 5.5;
  stdout.writeln("Penjumlahan: ${a + b}");
  stdout.writeln("Pembagian: ${a ~/ 3}");
  // -----------------------
  // 6. STRINGS
  // -----------------------
  String first = "Hello";
  String second = "World";
  stdout.writeln("$first $second");
  stdout.writeln("Panjang teks: ${first.length}");
  stdout.writeln("Huruf besar: ${second.toUpperCase()}");
  // -----------------------
  // 7. BOOLEANS
  // -----------------------
  bool isActive = false;
  stdout.writeln("Negasi: ${!isActive}");
  stdout.writeln("AND: ${isActive && isStudent}");
  stdout.writeln("OR: ${isActive || isStudent}");
  // -----------------------
  // 8. OPERATORS
  // -----------------------
  int x = 7;
  int y = 3;
  stdout.writeln("Tambah: ${x + y}");
  stdout.writeln("Kurang: ${x - y}");
  stdout.writeln("Kali: ${x * y}");
  stdout.writeln("Bagi: ${x / y}");
  stdout.writeln("Modulo: ${x % y}");
  stdout.writeln("Perbandingan: ${x > y}, ${x == y}");
  // -----------------------
  // 9. EXCEPTIONS
  // -----------------------
  try {
    int hasil = 10 ~/ 0; // error: division by zero
    stdout.writeln(hasil);
  } catch (e) {
    stdout.writeln("Terjadi error: $e");
  } finally {
    stdout.writeln("Bagian ini selalu jalan");
  }
    // -----------------------
  // 10. FUNCTIONS
  // -----------------------
  int tambah(int a, int b) {
    return a + b;
  }

  stdout.writeln("Fungsi tambah: ${tambah(5, 3)}");
  // -----------------------
  // 11. VARIABLE SCOPE
  // -----------------------
  int globalVar = 100;
  void innerFunction() {
    int localVar = 50;
    stdout.writeln("Global: $globalVar, Local: $localVar");
  }

  innerFunction();
  //stdout.writeln(localVar); // ERROR: localVar tidak bisa diakses di luar fungsi
   // -----------------------
  // 12. NULL SAFETY
  // -----------------------
  String? nullableString;
  nullableString = null;
  stdout.writeln("Nullable: $nullableString");

  String nonNullable = "Teks";
  stdout.writeln("Non-nullable: $nonNullable");

  String? maybeName;
  stdout.writeln("Default jika null: ${maybeName ?? "Guest"}");
}
