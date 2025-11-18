import 'package:encrypt/encrypt.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  // 1. Buat key dan IV (harus panjangnya sesuai)
  // AES-256 requires a 32-byte key (32 karakter)
  final key = Key.fromUtf8('0123456789ABCDEF0123456789ABCDEF'); 
  // AES requires a 16-byte IV (16 karakter)
  final iv = IV.fromUtf8('0123456789ABCDEF'); 

  // 2. Buat encrypter AES
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

  // --- ENKRIPSI DAN DEKRIPSI TEKS BIASA ---
  
  // 3. Data yang ingin dienkripsi
  final plainText = 'Ini rahasia besar saya 😉';

  // 4. Enkripsi
  final encrypted = encrypter.encrypt(plainText, iv: iv);
  print('🔒 Encrypted (base64): ${encrypted.base64}');

  // 5. Dekripsi
  final decrypted = encrypter.decrypt(encrypted, iv: iv);
  print('🔓 Decrypted text: $decrypted');
  
  print('---');

  // --- ENKRIPSI DAN DEKRIPSI DATA JSON ---
  
  // 6. Enkripsi data JSON
  final data = {'user': 'luqman', 'token': 'abc123xyz'};
  final jsonString = jsonEncode(data);
  
  final encryptedJson = encrypter.encrypt(jsonString, iv: iv);
  print('🔒 Encrypted JSON: ${encryptedJson.base64}');

  final decryptedJsonString = encrypter.decrypt(encryptedJson, iv: iv);
  final decryptedJson = jsonDecode(decryptedJsonString);
  print('🔓 Decrypted JSON: $decryptedJson');
}