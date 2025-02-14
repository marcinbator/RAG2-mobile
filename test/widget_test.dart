import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rag_2_mobile/models/Game.dart';
import 'package:rag_2_mobile/screens/game_selection_page.dart';
import 'package:rag_2_mobile/screens/game_page.dart';

void main() {
  group('Game Selection Tests', () {
    testWidgets('Should navigate to home page for selected game', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: GameSelectionPage()));

      expect(find.text('Pong'), findsOneWidget);

      await tester.tap(find.text('Pong'));
      await tester.pumpAndSettle();

      expect(find.text('Pong'), findsOneWidget);
    });
  });

  group('Home Page Tests', () {
    testWidgets('Should display IP address and connected devices count', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: GamePage(game: Game('Pong', '/pong'))));
      await tester.pumpAndSettle();
      expect(find.text('Połączonych urządzeń: 0'), findsOneWidget);
    });

    testWidgets('Should send correct action when control button is tapped', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: GamePage(game: Game('Pong', '/pong'))));

      expect(find.text("Góra"), findsOneWidget);

      await tester.tap(find.text('Góra'));
      await tester.pump();
    });
  });
}
