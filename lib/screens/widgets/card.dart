import 'package:effective_mobile_testovoe/models/character.dart';
import 'package:flutter/material.dart';

import '../../provider/character_provider.dart';

class CharacterCard extends StatelessWidget {
  final int index;
  final List<Character> characters;

  const CharacterCard({
    super.key,
    required this.index,
    required this.characters,
  });

  @override
  Widget build(BuildContext context) {
    final model = CharacterProvider.watch(context)!.model;
    final character = characters[index];
    return Card(
      color: Theme.of(context).colorScheme.onPrimary,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          spacing: 16,
          children: [
            CircleAvatar(
              foregroundImage: model.isConnected
                  ? NetworkImage(character.image)
                  : (character.imageBytes != null)
                      ? MemoryImage(character.imageBytes!)
                      : null,
              radius: 40,
            ),
            SizedBox(
              width: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    '${character.species} - ${character.status}',
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary),
                  )
                ],
              ),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  model.toggleFavorite(character);
                },
                icon: character.favorite
                    ? const Icon(Icons.star)
                    : const Icon(Icons.star_border)),
          ],
        ),
      ),
    );
  }
}
