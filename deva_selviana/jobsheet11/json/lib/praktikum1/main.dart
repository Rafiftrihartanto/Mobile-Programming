import 'user.dart';

void main() {
  // Object Dart ke JSON
  User user = User(
    id: 1,
    name: 'Deva Selviana',
    email: 'selvianadeva8@gmail.com',
    createdAt: DateTime.now(),
  ); // User

  Map<String, dynamic> userJson = user.toJson();
  print('User JSON: $userJson');

  // JSON ke Object Dart
  Map<String, dynamic> jsonData = {
    'id': 2,
    'name': 'depss',
    'email': 'depss@example.com',
    'created_at': '2024-01-01T10:00:00.000Z',
  };

  User userFromJson = User.fromJson(jsonData);
  print('User from JSON: ${userFromJson.name}');
}