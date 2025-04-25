class Character {
  final String image;
  final String name;
  final String species;
  final String status;
  bool favorite;

  Character({
    required this.image,
    required this.name,
    required this.species,
    required this.status,
    this.favorite = false,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      image: json['image'],
      name: json['name'],
      species: json['species'],
      status: json['status'],
    );
  }
}
