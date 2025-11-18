
void main(List<String> arguments) {
  // print('Hello world: ${project3.calculate()}!');

  //belajar fix list
  // var list = List<int>.filled(5, 0);

  // list[0] = 10;
  // list[1] = 20;
  // list[2] = 40;
  // list[3] = 30;
  // list[4] = 60;
  // // list[5] = 60; eror karena yang tersedia hanya 5
  // stdout.writeln("Data dari list: $list");

  //list fixed pakai perulangan
  // for (int i = 0; i <= 4; i++) {
  //   stdout.write(
  //     'Masukkan data ke-$i: ',
  //   ); // Minta input dari user untuk isi list
  //   var input = int.tryParse(
  //     stdin.readLineSync() ?? "",
  //   ); // Membaca input user (String) lalu mengubahnya ke integer
  //   list[i] =
  //       input ??
  //       0; // Menyimpan hasil input ke elemen list pada indeks ke-i (pakai ! karena kita yakin input bukan null)
  // }

  // stdout.writeln("Data dari list: $list");

  //list growable
  // var grow = [];
  // grow.add(20);
  // grow.add(30);
  // grow.remove(20);
  // stdout.writeln("Data di dalam list: $grow");

  // for (var i = 0; i <= 4; i++) {
  //   stdout.write("Data List ke-$i : ");
  //   var input = stdin.readLineSync();
  //   grow.add(int.parse((input == null || input.isEmpty) ? "0" : input));
  //   }
  //   print("Data dalam list = $grow");

  // var nama = [];
  // for (int i = 0; i <= 4; i++) {
  //   stdout.write("Data List ke-$i : ");
  //   var input = stdin.readLineSync();
  //   nama.add(input ?? "");
  // }
  // print("Data dalam list = $nama");

  // var angka = <int>{1, 2, 3, 3, 4};
  // stdout.writeln("Set angka ; $angka");
  // print("Elemen ke-2 : ${angka.elementAt(1)}");

  // var angka2 = <int>{4, 5, 6, 7, 8};
  // print("data union adalah= ${angka.union(angka2)}");
  // print("Data insersection adalah = ${angka.intersection(angka2)}");

  //map
  // var biodata = {"nim": "2341760028", "nama": "Farel", "jurusan": "TI"};
  // biodata["Angkatan"] = "2023";
  // print("Biodata Mahasiswa $biodata");
  // print("Biodata mahasiswa dengan nama = ${biodata['nama']}");

  //record
  // var mahasiswa = ("Farel", 20, true);
  // print("Ini data saya: $mahasiswa");
  // print("Mahasiswa = ${mahasiswa.$1}");

  // var bio = (nama: "farel maryam laila hajiri", umur: 20, gender: true);
  // print("bio daya $bio");
  // print("nama saya ${bio.nama}");

  //function
  // tampil("farel", 20, "malang");
  // tampil("jose", 20);

  //anonimous function
  // var nilai = [90, 80, 70, 100];
  // nilai.forEach((angka) {
  //   print("Nilai = $angka");
  // });

  //tugas no.1
  // Membuat growable list kosong untuk menyimpan nama mahasiswa
  // Membuat growable list dengan beberapa nama langsung
  // List<String> mahasiswa = [];

  // // Menambahkan data mahasiswa
  // mahasiswa.add("farel");
  // mahasiswa.add("adin");
  // mahasiswa.add("aida");
  // mahasiswa.add("dina");

  // // Menampilkan daftar mahasiswa
  // print("=== Daftar Nama Mahasiswa ===");
  // for (var mhs in mahasiswa) {
  //   print(mhs);
  // }

  // // Menampilkan jumlah mahasiswa
  // print("\nJumlah mahasiswa: ${mahasiswa.length}");

  // //tugas no2
  // // Input untuk Set A
  // stdout.write("Masukkan jumlah elemen Set A: ");
  // int? jumlahA = int.tryParse(stdin.readLineSync()!);
  // Set<int> setA = {};

  // for (int i = 0; i < (jumlahA ?? 0); i++) {
  //   stdout.write("Elemen ke-${i + 1} Set A: ");
  //   int? elemen = int.tryParse(stdin.readLineSync()!);
  //   if (elemen != null) {
  //     setA.add(elemen);
  //   }
  // }

  // // Input untuk Set B
  // stdout.write("\nMasukkan jumlah elemen Set B: ");
  // int? jumlahB = int.tryParse(stdin.readLineSync()!);
  // Set<int> setB = {};

  // for (int i = 0; i < (jumlahB ?? 0); i++) {
  //   stdout.write("Elemen ke-${i + 1} Set B: ");
  //   int? elemen = int.tryParse(stdin.readLineSync()!);
  //   if (elemen != null) {
  //     setB.add(elemen);
  //   }
  // }

  // // Menampilkan isi Set
  // print("\nSet A: $setA");
  // print("Set B: $setB");

  // // Union (gabungan)
  // Set<int> unionSet = setA.union(setB);
  // print("Union (A ∪ B): $unionSet");

  // // Intersection (irisan)
  // Set<int> intersectionSet = setA.intersection(setB);
  // print("Intersection (A ∩ B): $intersectionSet");

  //tugas no3
  // Map untuk menyimpan data barang dengan kode sebagai key
  // Map<String, Map<String, dynamic>> barang = {};

  // // Menambahkan minimal 3 barang
  // barang['B001'] = {
  //   'nama': 'TWS',
  //   'harga': 175000,
  // };
  // barang['B002'] = {
  //   'nama': 'Mouse',
  //   'harga': 98000,
  // };
  // barang['B003'] = {
  //   'nama': 'Keyboard Wireless',
  //   'harga': 215000,
  // };

  // // Menampilkan daftar barang
  // print("=== Daftar Barang ===");
  // barang.forEach((kode, data) {
  //   print("Kode: $kode | Nama: ${data['nama']} | Harga: Rp${data['harga']}");
  // });

  //tugas no5
  // Buat closure perhitungan diskon
  var hitungDiskon = buatDiskon();

  // Contoh belanja
  List<double> daftarBelanja = [120000, 70000, 30000];

  for (var belanja in daftarBelanja) {
    var hasil = hitungDiskon(belanja);
    print("Total Belanja: Rp${hasil['belanja']}");
    print("Diskon       : Rp${hasil['diskon']}");
    print("Total Bayar  : Rp${hasil['totalBayar']}\n");
  }
}

//function parameter
// void tampil(String nama, int umur, [String? alamat]) {
//   print("Nama: $nama");
//   print("Umur: $umur");
//   if (alamat != null) {
//     print("Alamat: $alamat");
//   } else {
//     print("alamat: -");
//   }
// }

// Fungsi closure untuk membuat perhitungan diskon
Function buatDiskon() {
  return (double totalBelanja) {
    double diskon = 0;

    if (totalBelanja >= 100000) {
      diskon = totalBelanja * 0.20; // 20%
    } else if (totalBelanja >= 50000) {
      diskon = totalBelanja * 0.10; // 10%
    }

    double totalBayar = totalBelanja - diskon;

    return {
      'belanja': totalBelanja,
      'diskon': diskon,
      'totalBayar': totalBayar,
    };
  };
}
