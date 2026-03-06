class Category {
  final int id;
  final String name;
  final String description;

  Category({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      description: json['description'] as String? ?? "",
    );
  }

   Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
      };
}