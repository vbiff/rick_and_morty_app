import 'dart:convert';

import 'package:effective_mobile_testovoe/models/character.dart';
import 'package:http/http.dart' as http;

class ApiSerivce {
  static const String _baseUrl = 'https://rickandmortyapi.com/api/character';

  Future<List<Character>> getCharacters({required int page}) async {
    final response = await http.get(Uri.parse('$_baseUrl?page=$page'));
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return List<Character>.from(
          data['results'].map((character) => Character.fromJson(character)));
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
