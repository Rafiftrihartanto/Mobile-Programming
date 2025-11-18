import 'user.dart';

void main() {
  // Object Dart ke JSON
  User user = User(
    id: 1,
    name: 'Izzatir Rofiah',
    email: 'izzatirof@gmail.com',
    createdAt: DateTime.now(),
  );

  Map<String, dynamic> userJson = user.toJson();
  print('User ke JSON: $userJson');

  // JSON ke Object Dart
  Map<String, dynamic> jsonData = {
    'id': 2,
    'name': 'Nur Lailatus Syaidah',
    'email': 'naltyda@gmail.com',
    'created_at': '2024-06-01T10:00:00Z',
  };

  User userFromJson = User.fromJson(jsonData);
  print('User dari JSON: ${userFromJson.name}');
}