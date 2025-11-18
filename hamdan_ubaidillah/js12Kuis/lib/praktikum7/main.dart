// main.dart (Praktikum 7 - Enkripsi AES)
import 'package:encrypt/encrypt.dart';
import 'dart:convert';

void main() {
  // 1. Buat key dan IV (harus panjangnya sesuai)
  final key = Key.fromUtf8(
    '0123456789ABCDEF0123456789ABCDEF',
  ); // 32 karakter = 256-bit key
  final iv = IV.fromUtf8('0123456789ABCDEF'); // 16 karakter = 128-bit IV

  // 2. Buat encrypter AES
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

  // 3. Data yang ingin dienkripsi
  final plainText = 'Ini rahasia besar saya';

  // 4. Enkripsi
  final encrypted = encrypter.encrypt(plainText, iv: iv);
  print('Encrypted (base64): ${encrypted.base64}');

  // 5. Dekripsi
  final decrypted = encrypter.decrypt(encrypted, iv: iv);
  print('Decrypted text: $decrypted');

  // Bisa juga enkripsi data JSON
  final data = {'user': 'luqman', 'token': 'abc123xyz'};
  final jsonString = jsonEncode(data);
  final encryptedJson = encrypter.encrypt(jsonString, iv: iv);
  print('Encrypted JSON: ${encryptedJson.base64}');

  final decryptedJson = encrypter.decrypt(encryptedJson, iv: iv);
  print('Decrypted JSON: $decryptedJson');
}