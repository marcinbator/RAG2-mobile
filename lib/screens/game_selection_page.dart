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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: Row(
            children: [
              Image.asset(
                'assets/rag2.png',
                height: 40,
              ),
              const SizedBox(width: 10),
              const Text("RAG2 Mobile"),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                "Select game",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: games.map((game) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      title: Text(
                        game.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GamePage(game: game),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
