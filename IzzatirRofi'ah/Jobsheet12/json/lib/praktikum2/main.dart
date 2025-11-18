import 'user.dart';

void main() {
  print('=== DEBUG: Check JSON Structure ===');

  // Object Dart ke JSON
  User user = User(
    id: 1,
    name: 'Izzatir Rofiah',
    email: 'izzatirrof@gmail.com',
    createdAt: DateTime.now(),  
  );

  Map<String, dynamic> userJson = user.toJson();
  print('User.toJson() result: $userJson');
  print('Field names: ${userJson.keys.toList()}');

  print('\n=== TEST: JSON to Object ===');

  // Gunakan field names yang sama dengan toJson() result
  Map<String, dynamic> jsonData = {
    'id': 2,
    'name': 'Nur Lailatus Syaidah',
    'email': 'naltyda@gmail.com',
    'createdAt': '2024-01-01T10:00:00.00Z',
  };

  // Debug: Print jsonData structure
  print('JSON data to parse: $jsonData');
  print('JSON keys: ${jsonData.keys.toList()}');
  print('id: ${jsonData['id']} (type: ${jsonData['id'].runtimeType})');
  print('name: ${jsonData['name']} (type: ${jsonData['name'].runtimeType})');
  print('email: ${jsonData['email']} (type: ${jsonData['email'].runtimeType})');
  print('createdAt: ${jsonData['createdAt']} (type: ${jsonData['createdAt'].runtimeType})');

  try {
    User userFromJson = User.fromJson(jsonData);
    print('SUCCESS: User dari JSON: ${userFromJson.name}');
  } catch (e, stack) {
    print('ERROR: $e');
    print('Stack Trace: $stack');
  }

  print('\n=== TEST: Handle Missing Fields ===');

  // Tess dengan missing fields
  Map<String, dynamic> incompleteJson = {
    'id': 3,
    // 'name': missing
    'email': 'test@example.com',
    // 'createdAt': missing
  };

  try {
    User userFromIncomplete = User.fromJson(incompleteJson);
    print('User from incomplete JSON: ${userFromIncomplete.name}');
  } catch (e) {
    print("Error with incomplete JSON: $e");
  }
}