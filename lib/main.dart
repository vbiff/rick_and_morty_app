import 'package:effective_mobile_testovoe/screens/home_screen.dart';
import 'package:effective_mobile_testovoe/state/character_model.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final model = CharacterWidgetModel();
    return CharacterProvider(
      model: model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
