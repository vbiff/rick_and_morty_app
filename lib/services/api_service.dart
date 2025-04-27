import 'dart:convert';
import 'dart:typed_data';

import 'package:effective_mobile_testovoe/models/character.dart';
import 'package:http/http.dart' as http;

class ApiSerivce {
  static const String _baseUrl = 'https://rickandmortyapi.com/api/character';

  Future<List<Character>> getCharacters({required int page}) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl?page=$page'));
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return List<Character>.from(
            data['results'].map((character) => Character.fromJson(character)));
      } else {
        throw Exception('Failed to load characters');
      }
    } catch (e) {
      print('Image download failed: $e');
    }
    return [];
  }

  Future<Uint8List> downloadImage(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
        return response.bodyBytes;
      }
    } catch (e) {
      print('Image download failed: $e');
    }
    return Uint8List(0); // Return empty bytes on failure
  }
}
