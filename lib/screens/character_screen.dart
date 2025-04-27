import 'package:effective_mobile_testovoe/provider/character_provider.dart';
import 'package:effective_mobile_testovoe/provider/theme_provider.dart';
import 'package:flutter/material.dart';

import 'widgets/card.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  final ScrollController _scrollController = ScrollController();
  late int currentPageIndex;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreItems);
    final model = CharacterProvider.read(context)?.model;
    model?.clearCharacterData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentPageIndex = 1;
      CharacterProvider.read(context)?.model.loadData(currentPageIndex);
    });
  }

  void _loadMoreItems() {
    if (!CharacterProvider.read(context)!.model.isConnected) {
      return;
    }
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      currentPageIndex++;
      CharacterProvider.read(context)?.model.loadData(currentPageIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = CharacterProvider.watch(context)?.model;
    final themeModel = ThemeProvider.watch(context)!.model;
    final characters = model?.characters ?? [];
    if (model?.characters.isEmpty == true && model?.isLoading == true) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
          title: const Text('Rick & Morty'),
          leading: themeModel.isDarkMode
              ? IconButton(
                  icon: Icon(Icons.light_mode),
                  onPressed: () {
                    themeModel.toggleTheme();
                  },
                )
              : IconButton(
                  icon: Icon(Icons.dark_mode),
                  onPressed: () {
                    themeModel.toggleTheme();
                  },
                )),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: characters.length + 1,
        itemBuilder: (context, index) {
          if (index == characters.length) {
            return Padding(
              padding: const EdgeInsets.all(32.0),
              child: Center(
                child: model?.isLoading ?? false
                    ? CircularProgressIndicator.adaptive()
                    : const SizedBox.shrink(),
              ),
            );
          }

          return CharacterCard(
            index: index,
            characters: model?.characters ?? [],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
