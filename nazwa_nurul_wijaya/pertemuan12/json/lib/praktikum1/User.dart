class User {
  final int id;
  final String name;
  final String email;
  final DateTime createdAt;

  User({
    // 'required' berarti properti ini wajib diisi saat membuat objek User
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  // 'factory constructor' digunakan untuk membuat instance dari Map (JSON)
  factory User.fromJson(Map<String, dynamic> json) {
    // Mengembalikan objek User baru yang diisi data dari 'json'
    return User(
      // Mengambil nilai dari Map 'json' dengan kunci 'id'
      id: json['id'],
      // Mengambil nilai dari Map 'json' dengan kunci 'name'
      name: json['name'],
      // Mengambil nilai dari Map 'json' dengan kunci 'email'
      email: json['email'],
      // Mengambil string tanggal dari 'json' dan mengubahnya (parse) menjadi objek DateTime
      createdAt: DateTime.parse(json['created_at']),
    );
  }
  // Method 'toJson' untuk mengonversi objek User saat ini menjadi sebuah Map
  Map<String, dynamic> toJson() {
    // Mengembalikan sebuah Map (struktur data JSON)
    return {
      // Menetapkan kunci 'id' di Map dengan nilai dari properti 'id'
      'id': id,
      // Menetapkan kunci 'name' di Map dengan nilai dari properti 'name'
      'name': name,
      // Menetapkan kunci 'email' di Map dengan nilai dari properti 'email'
      'email': email,
      // Mengonversi objek 'createdAt' (DateTime) menjadi format string ISO8601
      'created_at': createdAt.toIso8601String(),
    };
  }
}