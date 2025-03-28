import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rag_2_mobile/properties/colors.dart';

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
        textTheme: TextTheme(
                bodySmall: TextStyle(),
                bodyMedium: TextStyle(),
                bodyLarge: TextStyle())
            .apply(bodyColor: mainCreme, displayColor: mainCreme),
        fontFamily: GoogleFonts.firaCode().fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: mainOrange),
        primaryColorLight: mainCreme,
        primaryColorDark: mainGray,
        scaffoldBackgroundColor: mainGray,
        useMaterial3: true,
      ),
      home: const GameSelectionPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
