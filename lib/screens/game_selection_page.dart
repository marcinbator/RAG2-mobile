import 'package:flutter/material.dart';

import 'home_page.dart';

class GameSelectionPage extends StatelessWidget {
  const GameSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wybierz grę")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildGameButton(context, "Pong", "/pong"),
            const SizedBox(height: 20),
            _buildGameButton(context, "Flappybird", "/flappy"),
          ],
        ),
      ),
    );
  }

  Widget _buildGameButton(BuildContext context, String gameName, String path) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(title: gameName, gamePath: path),
          ),
        );
      },
      child: Text(gameName),
    );
  }
}
