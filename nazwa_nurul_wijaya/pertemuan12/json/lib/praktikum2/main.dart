import 'user.dart';
void main() {
  print("=== DEBUG: Check JSON Structure ===");

  // Object Dart → JSON
  User user = User(
    id: 1,
    name: 'Nazwa Nurul Wijaya',
    email: 'nazwa@email.com',
    createdAt: DateTime.now(),
  );

  Map<String, dynamic> userJson = user.toJson();
  print("User.toJson() result: $userJson");
  print("Field names: ${userJson.keys.toList()}");

  print("\n=== TEST: JSON → Dart Object ===");

  // JSON harus pakai field name yang sama dengan toJson()
  // Catatan: Jika 'createdAt' di User.toJson() menghasilkan 'createdAt',
  // maka JSON untuk fromJson() harus menggunakan nama field yang sama.
  // Kode asli Anda di atas menggunakan 'created_at', yang mungkin perlu disesuaikan
  // di kelas User jika tidak sesuai dengan User.toJson().
  // Saya akan menggunakan yang ada di gambar untuk tes berikutnya.
  Map<String, dynamic> jsonData = {
    'id': 2,
    'name': 'Mua Shobrina Jane',
    'email': 'mua@email.com',
    'createdAt': '2024-01-01T10:00:00.000Z',
  };

  //Debug: Print JSON structure and types
  print("JSON data to parse: $jsonData");
  print("JSON keys: ${jsonData.keys.toList()}");
  print("id: ${jsonData['id']} (type: ${jsonData['id'].runtimeType})");
  print("name: ${jsonData['name']} (type: ${jsonData['name'].runtimeType})");
  print("email: ${jsonData['email']} (type: ${jsonData['email'].runtimeType})");
  print(
      "createdAt: ${jsonData['createdAt']} (type: ${jsonData['createdAt'].runtimeType})");

  // Bagian dari kode awal Anda
  try {
    User userFromJson = User.fromJson(jsonData);
    print('✅ SUCCESS: User from JSON: $userFromJson');
  } catch (e, stack) {
    print('❌ ERROR: $e');
    print('Stack trace: $stack');
  }

  // Bagian dari gambar yang diunggah
  print('\n=== TEST: Handle Missing Fields ===');

  // Test dengan missing fields
  Map<String, dynamic> incompleteJson = {
    'id': 3,
    // 'name': missing
    'email': 'test@example.com',
    // 'createdAt': missing
  };

  try {
    User userFromIncomplete = User.fromJson(incompleteJson);
    print('User from incomplete JSON: $userFromIncomplete');
  } catch (e) {
    print('Error with incomplete JSON: $e');
  }
}