import 'package:effective_mobile_testovoe/models/character_adapter.dart';
import 'package:effective_mobile_testovoe/provider/theme_provider.dart';
import 'package:effective_mobile_testovoe/screens/home_screen.dart';
import 'package:effective_mobile_testovoe/provider/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CharacterAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final model = CharacterWidgetModel();
    final themeModel = ThemeModel();
    return ThemeProvider(
      model: themeModel,
      child: CharacterProvider(
        model: model,
        child: Builder(
          builder: (context) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Rick&Morty',
            theme: ThemeData(
                colorScheme:
                    ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent)),
            darkTheme: ThemeData.dark(),
            themeMode: ThemeProvider.watch(context)!.model.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            home: HomeScreen(),
          ),
        ),
      ),
    );
  }
}
