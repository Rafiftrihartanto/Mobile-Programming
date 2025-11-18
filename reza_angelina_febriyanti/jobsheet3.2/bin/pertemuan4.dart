import 'dart:async';

import 'package:jobsheet3/jobsheet3.dart' as jobsheet3;
import 'dart:io';

void main(List<String> arguments) {
  //print('Hello world: ${jobsheet3.calculate()}!');

  //Belajar Fixed List
  /*
  var list = List<int>.filled(5, 0);
  list[0] = 27;
  list[1] = 21;
  list[2] = 19;
  list[3] = 25;
  list[4] = 23;
  //list[5] = 28; //Eror karena disediakan tempat cuma 5
  print("Data dalam list = $list");
  */

  /*
  for (int i = 1; i <= 3; i++) {
    stdout.write("Masukkan nilai List ke $i: ");
    var input = int.parse(stdin.readLineSync() ?? '') ?? 0;
    list[i] = input;
  }

  print("Data dalam urut list = $list");
  */

  //Growable list
  /*
  var grow = [10];
  grow.add(20); //untuk menambah add
  grow.add(30);
  grow.add(40);
  grow.remove(50); //untuk menghapus remove

  print("Data dalam urut list = $grow");
  */

  /*
  //Menggunakan int
  List<int> Grow = List.filled(5, 0);

  for (var i = 0; i <= 4; i++) {
    stdout.write("Data List ke-$i : ");
    var input = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
    Grow[i] = input!;
  }
  print("Data dalam list = $Grow");
  */

  //Menggunakan string
  /*
  List<String> grow = [];

  for (var i = 0; i <= 4; i++) {
    stdout.write('Data list ke-$i : ');
    var input = stdin.readLineSync();
    if (input != null) {
      grow.add(input);
      print('data index ke: $i ${grow[i]}');
    }
  }
  print('data dalam list: $grow');
  */

  //SET
  /*
  var angka = <int> {1,2,3,3,4,5};
  //print("Datanya adalah ${angka.elementAt(1)}"); //menampilkan pada indeks ke

  var angka2 = <int> {4,5,6,7,8};
  print("Data Union adalah = ${angka.union(angka2)}"); //union=gabungan
  */

  //MAP
  /*
  var biodata = {
    "nim" : "2341760015",
    "nama" : "Reza Angelina",
    "jurusan" : "Teknologi Informasi"
  };
  */
  //print("Biodata Mahasiswa $biodata");
  //print("Biodata Mahasiswa dengan nama ${biodata["nama"]}");
  
  //Buat menambahkan map
  //biodata["Angkatan"] = "23";
  //rint("Biodata Mahasiswa $biodata");

  //BELAJAR RECORD
  //Tidak bisa menentukan identifier nya contoh 20 itu apa pada konteks dibawah
  //var mahasiswa = ("Angelina", 20, true);
  //print("Ini data saya: $mahasiswa");
  //print("Mahasiswa = ${mahasiswa.$1}"); //mencetak data ke-1 Angelina

  /*
  var bio = (nama:"Reza", umur:20, gender:true);
  print("Biodata  teman saya $bio");
  print("nama saya ${bio.nama}");
  */

  //FUNCTION
  /*
  void tampil(String nama, int umur, [String? alamat]) {
    print("Nama : $nama");
    print("Umur : $umur");
    if (alamat != null) {
      print("Alamat : $alamat");
    }
  }

  tampil("Reza", 20, "Malang");
  tampil("Vio", 22);
  */

  //Anonimous Function
  /*
  var nilai = [90, 80, 70, 100];
  nilai.forEach((angka){
    print("Nilai = ${angka}");
  });
  */
}