import 'package:flutter/material.dart';
import 'package:rag_2_mobile/properties/colors.dart';

import '../../models/game.dart';

class GameSteering {
  final void Function(String, int) sendAction;

  GameSteering(this.sendAction);

  List<Widget> generateControls(Game game) {
    List<Widget> controls;

    if (game.name == "Pong") {
      controls = [
        _buildControlButton("Up", "move", 1),
        const SizedBox(height: 10),
        _buildControlButton("Down", "move", -1),
      ];
    } else if (game.name == "Flappybird") {
      controls = [
        _buildControlButton("Jump", "jump", 1),
      ];
    } else {
      controls = [const Text("No steering available for this game.")];
    }
    return controls;
  }

  Widget _buildControlButton(String text, String actionName, int action) {
    return GestureDetector(
      onTapDown: (_) => sendAction(actionName, action),
      onTapUp: (_) => sendAction(actionName, 0),
      child: Container(
        width: 400,
        height: 250,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Center(
              child: Text(
                text,
                style: TextStyle(fontSize: 16, color: mainGray),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
