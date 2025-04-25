import 'package:flutter/material.dart';

import '../state/character_model.dart';

class CharacterCard extends StatelessWidget {
  final int index;

  const CharacterCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final character = CharacterProvider.watch(context)!.model.characters[index];
    return Card(
      color: Colors.grey[300],
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          spacing: 16,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(character.image),
              radius: 50,
            ),
            SizedBox(
              width: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text('${character.species} - ${character.status}')
                ],
              ),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  if (character.favorite) {
                    character.favorite = false;
                  } else {
                    character.favorite = true;
                  }
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
