// User.dart (Praktikum 3 - Safe Parsing)
class User {
  final int? id;
  final String? name;
  final String? email;
  final DateTime? createdAt;

  User({this.id, this.name, this.email, this.createdAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: _parseInt(json['id']),
      name: _parseString(json['name']),
      email: _parseString(json['email']),
      createdAt: _parseDateTime(
        json['created_at'] ?? json['createdAt'], // Handle both field names
      ),
    );
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    if (value is num) return value.toInt();
    return null;
  }

  static String? _parseString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    return value.toString();
  }
  
  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  // PERBAIKAN: Method toJson yang benar gunakan field instance [cite: 264, 265]
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'created_at': createdAt?.toIso8601String(), // Convert DateTime to String
    };
  }

  // Tambahkan method toString untuk debugging [cite: 273]
  @override
  String toString() {
    return 'SafeUser id: $id, name: $name, email: $email, createdAt: $createdAt}';
  }

  // Tambahkan method copyWith untuk immutability [cite: 279]
  User copyWith({int? id, String? name, String? email, DateTime? createdAt}) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // Tambahkan method untuk validasi [cite: 289]
  bool get isValid => id != null && name != null && name!.isNotEmpty;

  // Tambahkan method untuk compare objects [cite: 291]
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ email.hashCode ^ createdAt.hashCode;
}