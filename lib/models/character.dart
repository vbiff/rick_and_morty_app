import 'dart:typed_data';

class Character {
  final int id;
  final String image;
  final String name;
  final String species;
  final String status;
  bool favorite;
  Uint8List? imageBytes;

  Character({
    required this.id,
    required this.image,
    required this.name,
    required this.species,
    required this.status,
    this.favorite = false,
    Uint8List? imageBytes,
  }) : imageBytes = imageBytes ?? Uint8List(0);

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      species: json['species'],
      status: json['status'],
    );
  }
}
