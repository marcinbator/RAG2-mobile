import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const Rag2Mobile());
}

class Rag2Mobile extends StatelessWidget {
  const Rag2Mobile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rag2Mobile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Rag2Mobile'),
    );
  }
}
