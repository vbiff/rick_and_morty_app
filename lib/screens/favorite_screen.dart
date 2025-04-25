import 'package:effective_mobile_testovoe/state/character_model.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final model = CharacterWidgetModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rick & Morty')),
      body: ListView.builder(
        itemCount:
            CharacterProvider.watch(context)?.model.characters.length ?? 0,
        itemBuilder: (context, index) {
          final character =
              CharacterProvider.watch(context)!.model.characters[index];
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
                  IconButton(onPressed: () {}, icon: const Icon(Icons.star))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
