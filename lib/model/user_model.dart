class User {
  final int? id;
  final String name;
  final String email;
  final String role;
  final String status;

  User({
    required this.id, 
    required this.name, 
    required this.email,
    required this.role,
    required this.status,
    });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      role: json['role'] as String? ?? '',
      status: json['status'] as String? ?? '',
    );
  }
}