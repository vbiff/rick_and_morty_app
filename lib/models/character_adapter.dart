import 'package:effective_mobile_testovoe/models/character.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CharacterAdapter extends TypeAdapter<Character> {
  @override
  Character read(BinaryReader reader) {
    final id = reader.readInt();
    final image = reader.readString();
    final name = reader.readString();
    final species = reader.readString();
    final status = reader.readString();
    final favorite = reader.readBool();
    final imageBytes = reader.readByteList();

    return Character(
      id: id,
      image: image,
      name: name,
      species: species,
      status: status,
      favorite: favorite,
      imageBytes: imageBytes,
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, Character obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.image);
    writer.writeString(obj.name);
    writer.writeString(obj.species);
    writer.writeString(obj.status);
    writer.writeBool(obj.favorite);
    writer.writeByteList(obj.imageBytes as List<int>);
  }
}
