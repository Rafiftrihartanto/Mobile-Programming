import 'dart:io';

import 'package:jobsheet3/jobsheet3.dart' as jobsheet3;

void main(List<String> arguments) {
  //IF ELSE IF
  //int suhuTubuh = 35;
  stdout.write("Masukkan suhu tubuh anda : ");
  String? input = stdin.readLineSync();
  int suhuTubuh = int.parse(input ?? '') ?? 0;
  if ((suhuTubuh>=37) && (suhuTubuh<=42)){
    print("Anda sakit demam");
  } else if ((suhuTubuh>= 35) && (suhuTubuh<37)){
    print("Suhu tubuh anda normal");
  } else if ((suhuTubuh>=28) && (suhuTubuh<35)){
    print("Anda terkena hipotermia");
  } else {
    print("Maaf suhu tubuh anda tidak teridentifikasi");
  }

  //if else tradisional
  String kondisi;
  if ((suhuTubuh>=37) && (suhuTubuh<=42)){
    kondisi = "Anda mungkin reaktif Covid";
  } else {
    kondisi = "Anda mungkin non-reaktif Covid";
  }
  print(kondisi);

  //Ternary Operator
  String kondisi1 = ((suhuTubuh>=37) && (suhuTubuh<=42)) ? "Anda tidak boleh vaksin" : "Anda boleh vaksin";
  print(kondisi1);
  
}