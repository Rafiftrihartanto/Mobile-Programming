import 'package:encrypt/encrypt.dart';
import 'dart:convert';

void main() {
  // 1 buat key dan IV
  final key = Key.fromUtf8(
    '0123456789ABCDEF0123456789ABCDEF',
  ); // 32 Karakter = 256-bit key
  final iv = IV.fromUtf8('0123456789ABCDEF'); // 16 Karakter = 128-bit IV

  // 2 buat encrypter AES
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

  // 3 data yang ingin di encrypt
  final plainText = 'Ini rahasia besar saya 💦';

  // 4 encrypt 
  final encrypted = encrypter.encrypt(plainText, iv: iv);
  print('Encrypted (base64): ${encrypted.base64}');

  // 5 decrypt
  final decrypted = encrypter.decrypt64(encrypted.base64, iv: iv);
  print('Decrypted text: $decrypted');

  // 6 Bisa juga enkripsi data JSON
  final data = {'user': 'audric', 'token': 'abc123xyz'};
  final jsonString = jsonEncode(data);
  final encryptedJson = encrypter.encrypt(jsonString, iv: iv);
  print('Encrypted JSON: ${encryptedJson.base64}');

  final decryptedJson = encrypter.decrypt(encryptedJson, iv: iv);
  print('Decrypted JSON: $decryptedJson');
}