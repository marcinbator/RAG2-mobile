import 'package:flutter/material.dart';

import '../models/game.dart';
import 'game_page.dart';

class GameSelectionPage extends StatelessWidget {
  const GameSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Game> games = [
      const Game('Pong', '/pong'),
      const Game('Flappybird', '/flappy'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Select game")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: games.map((game) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: _buildGameButton(context, game),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildGameButton(BuildContext context, Game game) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GamePage(game: game),
          ),
        );
      },
      child: Text(game.name),
    );
  }
}
