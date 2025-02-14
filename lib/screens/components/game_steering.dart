import 'package:flutter/material.dart';

import '../../models/game.dart';

class GameSteering {
  final void Function(String, int) sendAction;

  GameSteering(this.sendAction);

  List<Widget> generateControls(Game game) {
    List<Widget> controls;

    if (game.name == "Pong") {
      controls = [
        _buildControlButton("Up", Colors.green, "move", 1),
        const SizedBox(height: 10),
        _buildControlButton("Down", Colors.red, "move", -1),
      ];
    } else if (game.name == "Flappybird") {
      controls = [
        _buildControlButton("Jump", Colors.green, "jump", 1),
      ];
    } else {
      controls = [const Text("No steering available for this game.")];
    }
    return controls;
  }

  Widget _buildControlButton(
      String text, Color color, String actionName, int action) {
    return GestureDetector(
      onTapDown: (_) => sendAction(actionName, action),
      onTapUp: (_) => sendAction(actionName, 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
