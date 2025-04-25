import 'package:effective_mobile_testovoe/services/api_service.dart';
import 'package:flutter/material.dart';

import '../models/character.dart';

//create changeNotifier to save model and methods
class CharacterWidgetModel extends ChangeNotifier {
  ApiSerivce apiSevice = ApiSerivce();
  var _characters = <Character>[];
  bool _isLoading = false;
  List<Character> get characters => _characters;
  bool get isLoading => _isLoading;
  // getter to make unable to change from outside

  Future<void> loadData(int currentIndex) async {
    _isLoading = true;
    notifyListeners();
    final characters = await apiSevice.getCharacters(page: currentIndex);
    _characters += characters;
    _isLoading = false;
    notifyListeners();
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
