// main.dart
import 'User.dart';

void main() {
  // Object Dart ke JSON [cite: 62]
  User user = User(
    id: 1,
    name: 'John Doe',
    email: 'john@example.com',
    createdAt: DateTime.now(),
  );
  Map<String, dynamic> userJson = user.toJson();
  print('User JSON: $userJson');

  // JSON ke Object Dart [cite: 71]
  Map<String, dynamic> jsonData = {
    'id': 2,
    'name': 'Jane Doe',
    'email': 'jane@example.com',
    'created_at': '2024-01-01T10:00:00.000Z',
  };
  User userFromJson = User.fromJson(jsonData);
  print('User from JSON: ${userFromJson.name}');
}