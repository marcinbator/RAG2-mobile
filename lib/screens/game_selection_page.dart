import 'package:flutter/material.dart';
import 'package:rag_2_mobile/data/colors.dart';

import '../data/games.dart';
import 'game_page.dart';

class GameSelectionPage extends StatelessWidget {
  const GameSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: lightGray,
          title: Row(
            children: [
              Image.asset(
                'assets/rag2.png',
                height: 40,
              ),
              const SizedBox(width: 10),
              const Text(
                "RAG2 Mobile",
                style: TextStyle(color: mainCreme),
              ),
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
                style: TextStyle(fontSize: 20, color: mainCreme),
              ),
            ),
            Expanded(
              child: ListView(
                children: games.map((game) {
                  return Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      title: Text(
                        game.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: mainOrange,
                      ),
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
