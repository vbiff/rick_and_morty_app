import 'dart:typed_data';

import 'package:effective_mobile_testovoe/services/api_service.dart';
import 'package:effective_mobile_testovoe/services/internet_connection_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/character.dart';

//create changeNotifier to save model and methods
class CharacterWidgetModel extends ChangeNotifier {
  ApiSerivce apiSevice = ApiSerivce();
  var _characters = <Character>[];
  var _favoriteCharacter = <String, Character>{};
  bool _isLoading = false;
  List<Character> get characters => _characters;
  Map<String, Character> get favoriteCharacter => _favoriteCharacter;
  bool get isLoading => _isLoading;
  bool isConnected = true;
  late Uint8List? imageBytes;

  // getter to make unable to change from outside

  Future<void> loadData(int currentIndex) async {
    _isLoading = true;
    notifyListeners();
    isConnected = await InternetConnectionService().checkConnection();
    notifyListeners();
    // Hive.deleteBoxFromDisk('cached_characters');
    // Hive.deleteBoxFromDisk('favorite_characters');
    final allBox = await Hive.openBox<Character>('cached_characters');
    final favoriteBox = await Hive.openBox<Character>('favorite_characters');
    //collect favorites from hive
    _favoriteCharacter.clear();
    favoriteBox.values
        .toList()
        .forEach((e) => _favoriteCharacter.putIfAbsent('${e.id}', () => e));

    //try to fetch data from API and if it doesn't work get data from hive
    // if we meet character from favorite, change start to favorite
    if (isConnected) {
      try {
        final charactersApi = await apiSevice.getCharacters(page: currentIndex);
        final charactersCopy = List<Character>.from(charactersApi);
        if (favoriteBox.isNotEmpty) {
          await Future.wait(
            charactersCopy.map((character) async {
              character.favorite = favoriteBox.containsKey('${character.id}');
              if (allBox.containsKey('${character.id}')) {
                character.imageBytes =
                    allBox.get('${character.id}')?.imageBytes;
              } else {
                character.imageBytes =
                    await apiSevice.downloadImage(character.image);
              }
            }),
          );

          _characters += charactersCopy;
        } else {
          await Future.wait(
            charactersCopy.map((character) async {
              if (allBox.containsKey('${character.id}')) {
                character.imageBytes =
                    allBox.get('${character.id}')?.imageBytes;
              } else {
                character.imageBytes =
                    await apiSevice.downloadImage(character.image);
              }
            }),
          );
          _characters += charactersCopy;
        }
        _isLoading = false;
        notifyListeners();

        await allBox.clear();
        for (var char in _characters) {
          await allBox.put('${char.id}', char);
        }
      } on Exception catch (_) {
        return;
      }
    } else {
      final charactersDb = allBox.values.toList();
      charactersDb.sort((a, b) => a.id.compareTo(b.id));
      for (var character in charactersDb) {
        character.favorite = favoriteBox.containsKey('${character.id}');
      }
      _characters += charactersDb;
    }
    _isLoading = false;
    notifyListeners();
  }

  void clearCharacterData() {
    _characters.clear();
  }

  void sortByName() {
    _favoriteCharacter = Map.fromEntries(_favoriteCharacter.entries.toList()
      ..sort((e1, e2) => e1.value.name.compareTo(e2.value.name)));
    notifyListeners();
  }

  void toggleFavorite(Character character) async {
    final favoriteBox = await Hive.openBox<Character>('favorite_characters');
    if (character.favorite == false) {
      character.favorite = true;
      await favoriteBox.put('${character.id}', character);
      _favoriteCharacter.putIfAbsent('${character.id}', () => character);
      _characters.firstWhere((e) => e.id == character.id).favorite = true;
      notifyListeners();
    } else {
      character.favorite = false;
      await favoriteBox.delete('${character.id}');
      _favoriteCharacter.remove('${character.id}');
      _characters.firstWhere((e) => e.id == character.id).favorite = false;
      notifyListeners();
    }
  }
}

class CharacterProvider extends InheritedNotifier {
  final CharacterWidgetModel model;

  const CharacterProvider({
    super.key,
    required this.model,
    required super.child,
  }) : super(
          notifier: model,
        );

//listen wish subscription
  static CharacterProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CharacterProvider>();
  }

//just get info without subscription
  static CharacterProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<CharacterProvider>()
        ?.widget;
    return widget is CharacterProvider ? widget : null;
  }
}
