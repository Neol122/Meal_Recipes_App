class FavoriteMeal {
  final String id;
  final String name;
  final String thumbnail;

  FavoriteMeal({
    required this.id,
    required this.name,
    required this.thumbnail,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'thumbnail': thumbnail,
    };
  }

  factory FavoriteMeal.fromMap(Map<String, dynamic> map) {
    return FavoriteMeal(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
    );
  }
}
