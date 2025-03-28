import 'package:flutter/material.dart';
import 'package:rag_2_mobile/screens/components/tilt_steering.dart';

import '../../data/colors.dart';
import '../../models/game.dart';

class GameSteering {
  final void Function(String, double) sendAction;

  GameSteering(this.sendAction);

  void _onControlByTiltClick(
      BuildContext context,
      String moveName,
      bool xAxisUsed,
      double valueOnSigned,
      double valueOnUnsigned,
      double valueOnNeutral) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return TiltControlModal(
          sendAction: sendAction,
          tooltipText: 'Tilt to steer',
          moveName: moveName,
          xAxisUsed: xAxisUsed,
          valueOnSigned: valueOnSigned,
          valueOnUnsigned: valueOnUnsigned,
          valueOnNeutral: valueOnNeutral,
        );
      },
    );
  }

  List<Widget> generateControls(Game game, BuildContext context) {
    return [
      ...game.buttons.map((button) =>
          _buildControlButton(button.text, button.actionName, button.action)),
      game.tilt
          ? TextButton.icon(
              icon: const Icon(Icons.filter_tilt_shift, color: mainCreme),
              label: const Text("Steer by tilt",
                  style: TextStyle(color: mainCreme)),
              onPressed: () => _onControlByTiltClick(
                  context,
                  game.buttons[0].actionName,
                  game.tiltUseXAxis,
                  game.buttons.map((button) => button.action).toList()[0],
                  game.buttons.map((button) => button.action).toList()[1],
                  0),
            )
          : Text("")
    ];
  }

  Widget _buildControlButton(String text, String actionName, double action) {
    return GestureDetector(
      onTapDown: (_) => sendAction(actionName, action),
      onTapUp: (_) => sendAction(actionName, 0),
      child: Container(
        width: 400,
        height: 200,
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
