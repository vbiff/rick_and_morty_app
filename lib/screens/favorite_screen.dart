import 'package:effective_mobile_testovoe/provider/character_provider.dart';
import 'package:flutter/material.dart';

import 'widgets/card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteList = CharacterProvider.watch(context)
            ?.model
            .favoriteCharacter
            .values
            .toList() ??
        [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: [
          TextButton(
              onPressed: () {
                CharacterProvider.read(context)?.model.sortByName();
              },
              child: Text('Sort by name'))
        ],
      ),
      body: ListView.builder(
        itemCount: favoriteList.length,
        itemBuilder: (context, index) {
          return CharacterCard(
            index: index,
            characters: favoriteList,
          );
        },
      ),
    );
  }
}
