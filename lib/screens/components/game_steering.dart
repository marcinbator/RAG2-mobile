import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rag_2_mobile/properties/colors.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../models/game.dart';

class GameSteering {
  final void Function(String, int) sendAction;

  GameSteering(this.sendAction);

  void _onControlByTiltClick(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return TiltControlModal(
            sendAction: sendAction,
            tooltipText: 'Tilt up or down to steer the paddle');
      },
    );
  }

  List<Widget> generateControls(Game game, BuildContext context) {
    List<Widget> controls;

    if (game.name == "Pong") {
      controls = [
        _buildControlButton("Up", "move", 1),
        const SizedBox(height: 10),
        _buildControlButton("Down", "move", -1),
        TextButton.icon(
          icon: const Icon(Icons.filter_tilt_shift, color: mainCreme),
          label:
              const Text("Steer by tilt", style: TextStyle(color: mainCreme)),
          onPressed: () => _onControlByTiltClick(context),
        )
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

class TiltControlModal extends StatefulWidget {
  final void Function(String, int) sendAction;
  final String tooltipText;

  const TiltControlModal(
      {required this.sendAction, super.key, required this.tooltipText});

  @override
  _TiltControlModalState createState() =>
      _TiltControlModalState(tooltipText: tooltipText);
}

class _TiltControlModalState extends State<TiltControlModal> {
  int currentAction = 0;
  double currentY = 0.0;
  String direction = '';
  final String tooltipText;
  late final StreamSubscription<AccelerometerEvent> _streamSubscription;

  _TiltControlModalState({required this.tooltipText});

  @override
  void initState() {
    super.initState();

    _streamSubscription = accelerometerEvents.listen((event) {
      double newY = event.y;
      String newDirection = '';

      if (newY > 0.5) {
        newDirection = 'Up';
        currentAction = 1;
      } else if (newY < -0.5) {
        newDirection = 'Down';
        currentAction = -1;
      } else {
        newDirection = 'Neutral';
        currentAction = 0;
      }

      setState(() {
        currentY = newY;
        direction = newDirection;
      });

      widget.sendAction("move", currentAction);
    });
  }

  @override
  void dispose() {
    // Anulowanie subskrypcji i wyłączenie sterowania tilt po zamknięciu modala
    _streamSubscription.cancel();
    widget.sendAction("move", 0); // Wyłączenie sterowania tilt
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Tilt to control"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tooltipText, style: TextStyle(color: mainGray)),
          const SizedBox(height: 20),
          Text("Y Position: ${currentY.toStringAsFixed(2)}",
              style: TextStyle(color: mainGray)),
          Text("Direction: $direction", style: TextStyle(color: mainGray)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Zamknięcie modala
            widget.sendAction(
                "move", 0); // Wyłączenie sterowania tilt po zamknięciu
          },
          child: const Text("Stop"),
        ),
      ],
    );
  }
}
