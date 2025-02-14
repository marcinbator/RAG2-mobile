import 'package:flutter/material.dart';

import 'screens/game_selection_page.dart';

void main() {
  runApp(const Rag2Mobile());
}

class Rag2Mobile extends StatelessWidget {
  const Rag2Mobile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RAG2 Mobile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const GameSelectionPage(),
    );
  }
}
