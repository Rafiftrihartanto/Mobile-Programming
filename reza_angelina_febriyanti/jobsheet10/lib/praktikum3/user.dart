class User {
  final int? id;
  final String? name;
  final String? email;
  final DateTime? createAt;

  User({this.id, this.name, this.email, this.createAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: _parseInt(json['id']),
      name: _parseString(json['name']),
      email: _parseString(json['email']),
      createAt: _parseDateTime(
        json['createAt'] ?? json['createdAt']
      ), 
    );
  }

  static int?_parseInt(dynamic value) {
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

  // ✅PERBAIKAN: Method toJson yang benar - gunakan field instance, bukan parameter json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'createAt': createAt?.toIso8601String(), // Convert DateTime to String  
    };
  }

  // ✅Tambahkan method toString untuk debugging
  @override
  String toString() {
    return 'SafeUser{id: $id, name: $name, email: $email, createAt: $createAt}';
  }

  // ✅Tambahkan method copyWith untuk immutability
  User copyWith({int? id, String? name, String? email, DateTime? createAt}) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      createAt: createAt ?? this.createAt,
    );
  }

  // ✅Tambahkan method untuk validasi
  bool get isValid => id != null && name != null && name!.isNotEmpty;

  // ✅Tambahkan method untuk compare objects
  @override
  bool operator == (Object other) =>
    identical(this, other) ||
    other is User &&
    runtimeType == other.runtimeType &&
    id == other.id &&
    name == other.name &&
    email == other.email &&
    createAt == other.createAt;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode ^ createAt.hashCode;
}